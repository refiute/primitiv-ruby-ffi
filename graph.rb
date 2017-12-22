require './status'
require './shape'

module Primitiv
	extend FFI::Library
	ffi_lib "libprimitiv_c.so"

	class Node < FFI::AutoPointer
		def self.release(ptr)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Node_delete(ptr)
			status.into_result
		end

		def initialize(ptr = nil)
			if ptr == nil
				status = Primitiv::Status.new
				ptr = Primitiv::safe_primitiv_Node_new(status)
				status.into_result
			end

			super ptr
		end

		def shape
			status = Primitiv::Status.new
			shape = Primitiv::safe_primitiv_Node_shape(self, status)
			status.into_result
			return shape
		end

		def to_f
			status = Primitiv::Status.new
			val = Primitiv::safe_primitiv_Node_to_float(self, status)
			status.into_result
			return val
		end

		def to_a
			status = Primitiv::Status.new
			size = self.shape.size
			array = FFI::MemoryPointer.new(:float, size)
			Primitiv::safe_primitiv_Node_to_array(self, array, status)
			status.into_result
			return array.read_array_of_float(size)
		end

		def backward
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Node_backward(self, status)
			status.into_result
		end

		def +@
			status = Primitiv::Status.new
			ptr = Primitiv::safe_primitiv_node_func_positive(self, status)
			status.into_result
			return ptr
		end

		def -@
			status = Primitiv::Status.new
			ptr = Primitiv::safe_primitiv_node_func_negative(self, status)
			status.into_result
			return ptr
		end
	end

	private
	attach_function :safe_primitiv_Node_new, [Primitiv::Status], :pointer
	attach_function :safe_primitiv_Node_new_with_movement, [Primitiv::Status], :pointer
	attach_function :safe_primitiv_Node_delete, [Primitiv::Node, Primitiv::Status], :pointer
	attach_function :safe_primitiv_Node_shape, [Primitiv::Node, Primitiv::Status], Primitiv::Shape
	attach_function :safe_primitiv_Node_to_float, [Primitiv::Node, Primitiv::Status], :float
	attach_function :safe_primitiv_Node_to_array, [Primitiv::Node, :pointer, Primitiv::Status], :void
	attach_function :safe_primitiv_Node_backward, [Primitiv::Node, Primitiv::Status], :void
	attach_function :safe_primitiv_node_func_positive, [Primitiv::Node, Primitiv::Status], Primitiv::Node
	attach_function :safe_primitiv_node_func_negative, [Primitiv::Node, Primitiv::Status], Primitiv::Node

	public
	class Graph < FFI::AutoPointer
		def self.release(ptr)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Graph_delete(ptr, status)
			status.into_result
		end

		def initialize
			status = Primitiv::Status.new
			ptr = Primitiv::safe_primitiv_Graph_new(status)
			status.into_result

			super ptr
		end

		def clear
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Graph_clear(self, status)
			status.into_result
		end

		def dump(format)
			raise ArgumentError if not format.is_a?(String)

			status = Primitiv::Status.new
			dump_str = Primitiv::safe_primitiv_Graph_dump(self, format, status)
			status.into_result
			return dump_str
		end

		def self.set_default(graph)
			raise ArgumentError if not graph.is_a?(Graph)

			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Graph_set_default(graph, status)
			status.into_result
		end
	end

	private
	attach_function :safe_primitiv_Graph_new, [Primitiv::Status], :pointer
	attach_function :safe_primitiv_Graph_delete, [Primitiv::Status], :void
	attach_function :safe_primitiv_Graph_clear, [Primitiv::Graph, Primitiv::Status], :void
	attach_function :safe_primitiv_Graph_set_default, [Primitiv::Graph, Primitiv::Status], :void
	attach_function :safe_primitiv_Graph_dump, [Primitiv::Graph, :string, Primitiv::Status], :string
end
