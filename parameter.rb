require 'ffi'
require './status'
require './shape'
require './device'
require './initializer'

require './type'

module Primitiv
	extend FFI::Library
	ffi_lib "libprimitiv_c.so"

	class Parameter < FFI::AutoPointer
		def self.release(ptr)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Parameter_delete(ptr, status)
			status.into_result
		end

		def initialize(shape = nil, value = nil, device = nil)
			status = Primitiv::Status.new
			if device != nil and not device.is_a?(Primitiv::Device)
				raise ArgumentError
			end

			if shape == nil
				ptr = Primitiv::safe_primitiv_Parameter_new(status)
			elsif value.is_a?(Array)
				size = value.size
				p_value = FFI::MemoryPointer.new(:float, size)
				p_value.write_array_of_uint32(value)
				ptr = Primitiv::safe_primitiv_Parameter_new_with_values(
					normShape(shape), p_value, size, device, status)
			elsif value.is_a?(Primitiv::Initializer)
				ptr = Primitiv::safe_primitiv_Parameter_new_with_initializer(
					normShape(shape), value, device, status)
			else
				raise ArgumentError
			end
			status.into_result

			super ptr
		end
	end

	private
	attach_function :safe_primitiv_Parameter_new, [Primitiv::Status], :pointer
	attach_function :safe_primitiv_Parameter_new_with_values,
		[Primitiv::Shape, :pointer, :size_t, :pointer], :pointer
	attach_function :safe_primitiv_Parameter_new_with_initializer,
		[Primitiv::Shape, :pointer, :pointer, Primitiv::Status], :pointer
	attach_function :safe_primitiv_Parameter_delete,
		[Primitiv::Parameter, Primitiv::Status], :void
end
