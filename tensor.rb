require 'ffi'

require './status'

module Primitiv
	extend FFI::Library
	ffi_lib "libprimitiv_c.so"

	class Tensor < FFI::AutoPointer
		def self.release(ptr)
		end

		def initialize
		end
	end
end
