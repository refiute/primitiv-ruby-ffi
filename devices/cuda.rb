require 'ffi'

require "./device"
require "./status"

module Primitiv
	module Devices
		extend FFI::Library
		ffi_lib "libprimitiv_c.dylib"

		class CUDA < Primitiv::Device
			def self.release(ptr)
				status = Primitiv::Status.new
				Primitiv::Devices::safe_primitiv_CUDA_delete(ptr, status)
				status.into_result
			end

			def initializer(device_id, rng_seed = nil)
				super device_id if device_id.is_a?(FFI::Pointer)

				status = Primitiv::Status.new
				if seed == nil
					ptr = Primitiv::Devices::safe_primitiv_CUDA_new(device_id, status)
				else
					ptr = Primitiv::Devices::safe_primitiv_CUDA_new_with_seed(
						device_id, rng_seed, status)
				end
				status.into_result
				return ptr
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
