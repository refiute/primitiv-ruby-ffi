require 'ffi'

require_relative 'status'

module Primitiv
	extend FFI::Library
	ffi_lib "primitiv_c"

	class Tensor < FFI::AutoPointer
		def self.release(ptr)
		end

		def initialize
		end
	end
end
