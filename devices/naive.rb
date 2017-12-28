require "ffi"

require "./device"
require "./status"

module Primitiv
	module Devices
		extend FFI::Library
		ffi_lib "primitiv_c"

		class Naive < Primitiv::Device
			def self.release(ptr)
				status = Primitiv::Status.new
				Primitiv::Devices::safe_primitiv_Naive_delete(ptr, status)
				status.into_result
			end

			def initialize(seed = nil)
				super seed if seed.is_a?(FFI::Pointer)

				status = Primitiv::Status.new
				if seed == nil
					ptr = Primitiv::Devices::safe_primitiv_Naive_new(status)
				elsif seed.is_a?(Integer)
					ptr = Primitiv::Devices::safe_primitiv_Naive_new_with_seed(seed, status)
				else
					raise ArgumentError
				end
				status.into_result

				super ptr
			end
		end

		private
		attach_function :safe_primitiv_Naive_new, [Primitiv::Status], :pointer
		attach_function :safe_primitiv_Naive_new_with_seed,
			[:uint32, Primitiv::Status], :pointer
		attach_function :safe_primitiv_Naive_delete,
			[Primitiv::Devices::Naive, Primitiv::Status], :void
	end
end
