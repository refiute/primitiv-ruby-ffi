require "ffi"

require "./status"

module Primitiv
	extend FFI::Library
	ffi_lib "primitiv_c"

	class Device < FFI::AutoPointer
		def self.get_default
			status = Primitiv::Status.new
			device = Primitiv::safe_primitiv_Device_get_default(status)
			status.into_result
			return device
		end

		def self.set_default(device)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Device_set_default(device, status)
			status.into_result
		end
	end

	private
	attach_function :safe_primitiv_Device_get_default,
		[Primitiv::Status], :pointer
	attach_function :safe_primitiv_Device_set_default,
		[:pointer, Primitiv::Status], :void
end
