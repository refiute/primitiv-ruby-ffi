require 'ffi'

require './status'

module Primitiv
	extend FFI::Library
	ffi_lib "libprimitiv_c.dylib"

	class Tensor < FFI::AutoPointer
		def self.release(ptr)
		end

		def initialize
		end
	end
end
