require 'ffi'

require './status'
require './initializer'

module Primitiv
	module Initializers
		extend FFI::Library
		ffi_lib "libprimitiv_c.so"

		class Constant < Primitiv::Initializer
			def self.release(ptr)
				status = Primitiv::Status.new
				Primitiv::Initializers::safe_primitiv_Constant_delete(ptr, status)
				status.into_result
			end

			def initialize(k)
				status = Primitiv::Status.new
				ptr = Primitiv::Initializers::safe_primitiv_Constant_new(k, status)
				status.into_result

				super ptr
			end
		end

		private
		attach_function :safe_primitiv_Constant_new, [:float, Primitiv::Status], :pointer
		attach_function :safe_primitiv_Constant_delete,
			[Primitiv::Initializers::Constant, Primitiv::Status], :void

		public
		class XavierUniform < Primitiv::Initializer
			def self.release(ptr)
				status = Primitiv::Status.new
				Primitiv::Initializers::safe_primitiv_XavierUniform_delete(ptr, status)
				status.into_result
			end

			def initialize(scale = 1.0)
				status = Primitiv::Status.new
				ptr = Primitiv::Initializers::safe_primitiv_XavierUniform_new(scale, status)
				status.into_result

				super ptr
			end
		end

		private
		attach_function :safe_primitiv_XavierUniform_new, [:float, Primitiv::Status], :pointer
		attach_function :safe_primitiv_XavierUniform_delete,
			[Primitiv::Initializers::XavierUniform, Primitiv::Status], :void
	end
end
