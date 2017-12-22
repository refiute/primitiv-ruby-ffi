require 'ffi'

require "./status"

module Primitiv
	extend FFI::Library
	ffi_lib "libprimitiv_c.dylib"

	class Shape < FFI::AutoPointer
		def self.release(ptr)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Shape_delete(ptr, status)
			status.into_result
		end

		def initialize(dims = nil, batch = 1)
			status = Primitiv::Status.new

			if dims == nil
				ptr = Primitiv::safe_primitiv_Shape_new(status)
			elsif dims.is_a?(Array)
				size = dims.size()
				p = FFI::MemoryPointer.new(:uint32, size)
				p.write_array_of_uint32(dims)
				ptr = Primitiv::safe_primitiv_Shape_new_with_dims(p, size, batch, status)
			elsif dims.is_a?(FFI::Pointer)
				ptr = dims
			else
				raise ArgumentError
			end
			status.into_result

			super ptr
		end

		def get_item(i)
			raise ArgumentError if not i.is_a?(Integer)

			status = Primitiv::Status.new
			item = Primitiv::safe_primitiv_Shape_op_getitem(self, i, status)
			status.into_result
			return item
		end

		def depth
			status = Primitiv::Status.new
			ret = Primitiv::safe_primitiv_Shape_depth(self, status)
			status = Primitiv::Status.new
			return ret
		end

		def batch
			status = Primitiv::Status.new
			ret = Primitiv::safe_primitiv_Shape_batch(self, status)
			status = Primitiv::Status.new
			return ret
		end

		def volume
			status = Primitiv::Status.new
			ret = Primitiv::safe_primitiv_Shape_volume(self, status)
			status = Primitiv::Status.new
			return ret
		end

		def size
			status = Primitiv::Status.new
			ret = Primitiv::safe_primitiv_Shape_size(self, status)
			status = Primitiv::Status.new
			return ret
		end

		def to_s
			status = Primitiv::Status.new
			ret = Primitiv::safe_primitiv_Shape_to_string(self, status)
			status = Primitiv::Status.new
			return ret
		end
	end

	private
	attach_function :safe_primitiv_Shape_new, [Primitiv::Status], :pointer
	attach_function :safe_primitiv_Shape_new_with_dims,
		[:pointer, :size_t, :uint32, Primitiv::Status], :pointer
	attach_function :safe_primitiv_Shape_delete, [Primitiv::Shape, Primitiv::Status], :void
	attach_function :safe_primitiv_Shape_op_getitem,
		[Primitiv::Shape, :uint32, Primitiv::Status], :uint32
	attach_function :safe_primitiv_Shape_depth, [Primitiv::Shape, Primitiv::Status], :uint32
	attach_function :safe_primitiv_Shape_batch, [Primitiv::Shape, Primitiv::Status], :uint32
	attach_function :safe_primitiv_Shape_volume, [Primitiv::Shape, Primitiv::Status], :uint32
	attach_function :safe_primitiv_Shape_size, [Primitiv::Shape, Primitiv::Status], :uint32
	attach_function :safe_primitiv_Shape_to_string, [Primitiv::Shape, Primitiv::Status], :string
end
