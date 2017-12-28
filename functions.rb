require 'ffi'

require './status'
require './graph'
require './tensor'

module Primitiv
	module Functions
		extend FFI::Library
		ffi_lib "primitiv_c"

		public
		def self.add(left, right)
			status = Primitiv::Status.new
			if left.is_a?(Primitiv::Node)
				if right.is_a?(Primitiv::Node)
					ptr = Primitiv::Functions::safe_primitiv_node_func_add_node_node(left, right, status)
				else # right is a Float
					ptr = Primitiv::Functions::safe_primitiv_node_func_add_node_const(left, right, status)
				end
			elsif left.is_a?(Primitiv::Tensor)
				if right.is_a?(Primitiv::Tensor)
					ptr = Primitiv::Functions::safe_primitiv_node_func_add_tensor_tensor(left, right, status)
				else # right is a Float
					ptr = Primitiv::Functions::safe_primitiv_node_func_add_tensor_const(left, right, status)
				end
			else # left is a Float
				if right.is_a?(Primitiv::Node)
					ptr = Primitiv::Functions::safe_primitiv_node_func_add_const_node(left, right, status)
				else # right is a Primitiv::Tensor
					ptr = Primitiv::Functions::safe_primitiv_node_func_add_const_tensor(left, right, status)
				end
			end
			status.into_result

			return ptr
		end

		private
		attach_function :safe_primitiv_node_func_add_node_const,
			[Primitiv::Node, :float, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_node_func_add_const_node,
			[:float, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_node_func_add_node_node,
			[Primitiv::Node, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_add_tensor_const,
			[Primitiv::Tensor, :float, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_tensor_func_add_const_tensor,
			[:float, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_tensor_func_add_tensor_tensor,
			[Primitiv::Tensor, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor

		public
		def self.subtract(left, right)
			status = Primitiv::Status.new
			if left.is_a?(Primitiv::Node)
				if right.is_a?(Primitiv::Node)
					ptr = Primitiv::Functions::safe_primitiv_node_func_subtract_node_node(left, right, status)
				else # right is a Float
					ptr = Primitiv::Functions::safe_primitiv_node_func_subtract_node_const(left, right, status)
				end
			elsif left.is_a?(Primitiv::Tensor)
				if right.is_a?(Primitiv::Tensor)
					ptr = Primitiv::Functions::safe_primitiv_node_func_subtract_tensor_tensor(left, right, status)
				else # right is a Float
					ptr = Primitiv::Functions::safe_primitiv_node_func_subtract_tensor_const(left, right, status)
				end
			else # left is a Float
				if right.is_a?(Primitiv::Node)
					ptr = Primitiv::Functions::safe_primitiv_node_func_subtract_const_node(left, right, status)
				else # right is a Primitiv::Tensor
					ptr = Primitiv::Functions::safe_primitiv_node_func_subtract_const_tensor(left, right, status)
				end
			end
			status.into_result

			return ptr
		end

		private
		attach_function :safe_primitiv_node_func_subtract_node_const,
			[Primitiv::Node, :float, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_node_func_subtract_const_node,
			[:float, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_node_func_subtract_node_node,
			[Primitiv::Node, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_subtract_tensor_const,
			[Primitiv::Tensor, :float, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_tensor_func_subtract_const_tensor,
			[:float, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_tensor_func_subtract_tensor_tensor,
			[Primitiv::Tensor, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor

		public
		def self.multiply(left, right)
			status = Primitiv::Status.new
			if left.is_a?(Primitiv::Node)
				if right.is_a?(Primitiv::Node)
					ptr = Primitiv::Functions::safe_primitiv_node_func_multiply_node_node(left, right, status)
				else # right is a Float
					ptr = Primitiv::Functions::safe_primitiv_node_func_multiply_node_const(left, right, status)
				end
			elsif left.is_a?(Primitiv::Tensor)
				if right.is_a?(Primitiv::Tensor)
					ptr = Primitiv::Functions::safe_primitiv_node_func_multiply_tensor_tensor(left, right, status)
				else # right is a Float
					ptr = Primitiv::Functions::safe_primitiv_node_func_multiply_tensor_const(left, right, status)
				end
			else # left is a Float
				if right.is_a?(Primitiv::Node)
					ptr = Primitiv::Functions::safe_primitiv_node_func_multiply_const_node(left, right, status)
				else # right is a Primitiv::Tensor
					ptr = Primitiv::Functions::safe_primitiv_node_func_multiply_const_tensor(left, right, status)
				end
			end
			status.into_result

			return ptr
		end

		private
		attach_function :safe_primitiv_node_func_multiply_node_const,
			[Primitiv::Node, :float, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_node_func_multiply_const_node,
			[:float, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_node_func_multiply_node_node,
			[Primitiv::Node, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_multiply_tensor_const,
			[Primitiv::Tensor, :float, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_tensor_func_multiply_const_tensor,
			[:float, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_tensor_func_multiply_tensor_tensor,
			[Primitiv::Tensor, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor

		public
		def self.divide(left, right)
			status = Primitiv::Status.new
			if left.is_a?(Primitiv::Node)
				if right.is_a?(Primitiv::Node)
					ptr = Primitiv::Functions::safe_primitiv_node_func_divide_node_node(left, right, status)
				else # right is a Float
					ptr = Primitiv::Functions::safe_primitiv_node_func_divide_node_const(left, right, status)
				end
			elsif left.is_a?(Primitiv::Tensor)
				if right.is_a?(Primitiv::Tensor)
					ptr = Primitiv::Functions::safe_primitiv_node_func_divide_tensor_tensor(left, right, status)
				else # right is a Float
					ptr = Primitiv::Functions::safe_primitiv_node_func_divide_tensor_const(left, right, status)
				end
			else # left is a Float
				if right.is_a?(Primitiv::Node)
					ptr = Primitiv::Functions::safe_primitiv_node_func_divide_const_node(left, right, status)
				else # right is a Primitiv::Tensor
					ptr = Primitiv::Functions::safe_primitiv_node_func_divide_const_tensor(left, right, status)
				end
			end
			status.into_result

			return ptr
		end

		private
		attach_function :safe_primitiv_node_func_divide_node_const,
			[Primitiv::Node, :float, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_node_func_divide_const_node,
			[:float, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_node_func_divide_node_node,
			[Primitiv::Node, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_divide_tensor_const,
			[Primitiv::Tensor, :float, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_tensor_func_divide_const_tensor,
			[:float, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_tensor_func_divide_tensor_tensor,
			[Primitiv::Tensor, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor

		public
		def self.input(shape, data, device = nil, graph = nil)
			raise ArgumentError, "data must be Array class" if not data.is_a?(Array)
			if device != nil and not device.is_a?(Primitiv::Device)
				raise ArgumentError, "device must be Primitiv::Device or nil"
			end
			if graph != nil and not graph.is_a?(Primitiv::Graph)
				raise ArgumentError, "graph must be Primitiv::Graph or nil"
			end

			status = Primitiv::Status.new
			size = data.size
			p_data = FFI::MemoryPointer.new(:float, size)
			p_data.write_array_of_float(data)
			node = Primitiv::Functions::safe_primitiv_node_func_input(
				shape, p_data, size, device, graph, status)
			status.into_result
			return node
		end

		private
		attach_function :safe_primitiv_node_func_input,
			[Primitiv::Shape, :pointer, :size_t, :pointer, :pointer, Primitiv::Status],
			Primitiv::Node

		public
		def self.parameter(param, graph = nil)
			status = Primitiv::Status.new
			node = Primitiv::Functions::safe_primitiv_node_func_parameter(param, graph, status)
			status.into_result
			return node
		end

		private
		attach_function :safe_primitiv_node_func_parameter,
			[Primitiv::Parameter, Primitiv::Graph, Primitiv::Status], Primitiv::Node

		public
		def self.matmul(left, right)
			status = Primitiv::Status.new
			if left.is_a?(Primitiv::Node)
				ret = Primitiv::Functions::safe_primitiv_node_func_matmul(left, right, status)
			else
				ret = Primitiv::Functions::safe_primitiv_tensor_func_matmul(left, right, status)
			end
			status.into_result
			return ret
		end

		private
		attach_function :safe_primitiv_node_func_matmul,
			[Primitiv::Node, Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_matmul,
			[Primitiv::Tensor, Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor

		public
		def self.tanh(x)
			status = Primitiv::Status.new
			if x.is_a?(Primitiv::Node)
				ret = Primitiv::Functions::safe_primitiv_node_func_tanh(x, status)
			elsif x.is_a?(Primitiv::Tensor)
				ret = Primitiv::Functions::safe_primitiv_tensor_func_tanh(x, status)
			else
				raise ArgumentError
			end
			status.into_result
			return ret
		end

		private
		attach_function :safe_primitiv_node_func_tanh,
			[Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_tanh,
			[Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor

		public
		def self.relu(x)
			status = Primitiv::Status.new
			if x.is_a?(Primitiv::Node)
				ret = Primitiv::Functions::safe_primitiv_node_func_relu(x, status)
			elsif x.is_a?(Primitiv::Tensor)
				ret = Primitiv::Functions::safe_primitiv_tensor_func_relu(x, status)
			else
				raise ArgumentError, "x must be Primitiv::Node or Primitiv::Tensor"
			end
			status.into_result
			return ret
		end

		private
		attach_function :safe_primitiv_node_func_relu,
			[Primitiv::Node, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_relu,
			[Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor

		public
		def self.softmax_cross_entropy(x, t, dim)
			status = Primitiv::Status.new
			if x.is_a?(Primitiv::Node)
				if t.is_a?(Primitiv::Node)
					ret = Primitiv::Functions::safe_primitiv_node_func_softmax_cross_entropy(x, t, dim, status)
				else
					size = t.size
					p_t = FFI::MemoryPointer.new(:uint32, size)
					p_t.write_array_of_uint32(t)
					ret =
						Primitiv::Functions::safe_primitiv_node_func_softmax_cross_entropy_with_array(
							x, p_t, size, dim, status)
				end
			else
				if t.is_a?(Primitiv::Tensor)
					ret = Primitiv::Functions::safe_primitiv_tensor_func_softmax_cross_entropy(x, t, dim, status)
				else
					size = t.size
					p_t = FFI::MemoryPointer.new(:uint32, size)
					p_t.write_array_of_uint32(t)
					ret =
						Primitiv::Functions::safe_primitiv_tensor_func_softmax_cross_entropy_with_array(
							x, p_t, size, dim, status)
				end
			end
			status.into_result
			return ret
		end

		private
		attach_function :safe_primitiv_node_func_softmax_cross_entropy,
			[Primitiv::Node, Primitiv::Node, :uint32, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_softmax_cross_entropy,
			[Primitiv::Tensor, Primitiv::Tensor, :uint32, Primitiv::Status], Primitiv::Tensor
		attach_function :safe_primitiv_node_func_softmax_cross_entropy_with_array,
			[Primitiv::Node, :pointer, :size_t, :uint32, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_softmax_cross_entropy_with_array,
			[Primitiv::Tensor, :pointer, :size_t, :uint32, Primitiv::Status], Primitiv::Tensor

		public
		def self.dropout(x, rate, train)
			status = Primitiv::Status.new
			if x.is_a?(Primitiv::Node)
				ret = Primitiv::Functions::safe_primitiv_node_func_dropout(x, rate, train, status)
			elsif x.is_a?(Primitiv::Tensor)
				ret = Primitiv::Functions::safe_primitiv_tensor_func_dropout(x, rate, train, status)
			else
				raise ArgumentError, "x must be Primitiv:Node or Primitiv::Tensor"
			end
			status.into_result
			return ret
		end

		private
		attach_function :safe_primitiv_node_func_dropout,
			[Primitiv::Node, :float, :bool, Primitiv::Status], Primitiv::Node
		attach_function :safe_primitiv_tensor_func_dropout,
			[Primitiv::Tensor, :float, :bool, Primitiv::Status], Primitiv::Tensor

		module Batch
			extend FFI::Library
			ffi_lib "primitiv_c"

			def self.mean(x)
				status = Primitiv::Status.new
				if x.is_a?(Primitiv::Node)
					ret = Primitiv::Functions::Batch::safe_primitiv_node_func_batch_mean(x, status)
				elsif x.is_a?(Primitiv::Tensor)
					ret = Primitiv::Functions::Batch::safe_primitiv_tensor_func_batch_mean(x, status)
				else
					raise ArgumentError, "x must be Primitiv::Node or Primitiv::Tensor"
				end
				status.into_result
				return ret
			end

			attach_function :safe_primitiv_node_func_batch_mean,
				[Primitiv::Node, Primitiv::Status], Primitiv::Node
			attach_function :safe_primitiv_tensor_func_batch_mean,
				[Primitiv::Tensor, Primitiv::Status], Primitiv::Tensor
		end
	end
end
