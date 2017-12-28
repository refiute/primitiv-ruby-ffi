require 'ffi'

module Primitiv
	extend FFI::Library
	ffi_lib "primitiv_c"

	Code = enum(:OK,
							:ERROR,
							:CANCELLED,
							:UNKNOWN,
							:INVALID_ARGUMENT,
							:DEADLINE_EXCEEDED,
							:NOT_FOUND,
							:ALREADY_EXISTS,
							:PERMISSION_DENIED,
							:RESOURCE_EXHAUSTED,
							:FAILED_PRECONDITION,
							:ABORTED,
							:OUT_OF_RANGE,
							:UNIMPLEMENTED,
							:INTERNAL,
							:UNAVAILABLE,
							:DATA_LOSS,
							:UNAUTHENTICATED)

	class Status < FFI::AutoPointer
		def self.release(ptr)
			Primitiv::primitiv_Status_delete(ptr)
		end

		def initialize(ptr = nil)
			ptr = Primitiv::primitiv_Status_new if ptr == nil
			super ptr
		end

		def set(code, file, line, message)
			Primitiv::primitiv_Status_set_status(self, code, file, line, message)
		end

		def code
			return Primitiv::primitiv_Status_get_code(self)
		end

		def message
			return Primitiv::primitiv_Status_get_message(self)
		end

		def is_ok?
			return self.code == :OK
		end

		def into_result
			raise RuntimeError, self.message if not self.is_ok?
		end
	end

	private
	attach_function :primitiv_Status_new, [], :pointer
	attach_function :primitiv_Status_delete, [Primitiv::Status], :void
	attach_function :primitiv_Status_set_status,
		[Primitiv::Status, Code, :string, :uint32, :string], :void
	attach_function :primitiv_Status_get_code, [Primitiv::Status], Code
	attach_function :primitiv_Status_get_message, [Primitiv::Status], :string
end
