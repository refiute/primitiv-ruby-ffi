require 'ffi'

require_relative "../device"
require_relative "../status"

module Primitiv
	module Devices
		extend FFI::Library
		ffi_lib "primitiv_c"

		class CUDA < Primitiv::Device
			def self.release(ptr)
				status = Primitiv::Status.new
				Primitiv::Devices::safe_primitiv_CUDA_delete(ptr, status)
				status.into_result
			end

			def initialize(device_id, rng_seed = nil)
				super device_id if device_id.is_a?(FFI::Pointer)
				raise ArgumentError if not device_id.is_a?(Integer)

				status = Primitiv::Status.new
				if rng_seed == nil
					ptr = Primitiv::Devices::safe_primitiv_CUDA_new(device_id, status)
				elsif rng_seed.is_a?(Integer)
					ptr = Primitiv::Devices::safe_primitiv_CUDA_new_with_seed(
						device_id, rng_seed, status)
				else
					raise ArgumentError
				end
				status.into_result

				super ptr
			end
		end

		private
		attach_function :safe_primitiv_CUDA_new, [:uint32, Primitiv::Status], :pointer
		attach_function :safe_primitiv_CUDA_new_with_seed,
			[:uint32, :uint32, Primitiv::Status], :pointer
		attach_function :safe_primitiv_CUDA_delete,
			[Primitiv::Devices::CUDA, Primitiv::Status], :void
	end
end
