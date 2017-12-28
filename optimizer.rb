require 'ffi'

require_relative 'parameter'
require_relative 'status'

module Primitiv
	class Optimizer < FFI::AutoPointer
		def load(path)
			raise ArgumentError if not path.is_a?(String)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_load(self, path, status)
			status.into_result
		end

		def save(path)
			raise ArgumentError if not path.is_a?(String)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_save(self, path, status)
			status.into_result
		end

		def get_epoch
			status = Primitiv::Status.new
			epoch = Primitiv::safe_primitiv_Optimizer_get_epoch(self, status)
			status.into_result
			return epoch
		end

		def set_epoch(epoch)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_set_epoch(self, epoch, status)
			status.into_result
		end

		def get_learning_rate_scaling
			status = Primitiv::Status.new
			scale = Primitiv::safe_primitiv_Optimizer_get_learning_rate_scaling(self, status)
			status.into_result
			return scale
		end

		def set_learning_rate_scaling(scale)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_set_learning_rate_scaling(self, scale, status)
			status.into_result
		end

		def get_weight_decay
			status = Primitiv::Status.new
			strength = Primitiv::safe_primitiv_Optimizer_get_weight_decay(self, status)
			status.into_result
			return strength
		end

		def set_weight_decay(strength)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_set_weight_decay(self, strength, status)
			status.into_result
		end

		def get_gradient_clipping
			status = Primitiv::Status.new
			threshold = Primitiv::safe_primitiv_Optimizer_get_gradient_clipping(self, status)
			status.into_result
			return threshold
		end

		def set_gradient_clipping(threshold)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_set_gradient_clipping(self, threshold, status)
			status.into_result
		end

		def add_parameter(param)
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_add_parameter(self, param, status)
			status.into_result
		end

		def reset_gradients
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_reset_gradients(self, status)
			status.into_result
		end

		def update
			status = Primitiv::Status.new
			Primitiv::safe_primitiv_Optimizer_update(self, status)
			status.into_result
		end
	end

	private
	attach_function :safe_primitiv_Optimizer_load, [:pointer, :string, Primitiv::Status], :void
	attach_function :safe_primitiv_Optimizer_save, [:pointer, :string, Primitiv::Status], :void
	attach_function :safe_primitiv_Optimizer_get_epoch, [:pointer, Primitiv::Status], :uint32
	attach_function :safe_primitiv_Optimizer_set_epoch, [:pointer, :uint32, Primitiv::Status], :void
	attach_function :safe_primitiv_Optimizer_get_learning_rate_scaling,
		[:pointer, Primitiv::Status], :float
	attach_function :safe_primitiv_Optimizer_set_learning_rate_scaling,
		[:pointer, :float, Primitiv::Status], :void
	attach_function :safe_primitiv_Optimizer_get_weight_decay, [:pointer, Primitiv::Status], :float
	attach_function :safe_primitiv_Optimizer_set_weight_decay,
		[:pointer, :float, Primitiv::Status], :void
	attach_function :safe_primitiv_Optimizer_get_gradient_clipping,
		[:pointer, Primitiv::Status], :float
	attach_function :safe_primitiv_Optimizer_set_gradient_clipping,
		[:pointer, :float, Primitiv::Status], :void
	attach_function :safe_primitiv_Optimizer_add_parameter,
		[:pointer, Primitiv::Parameter, Primitiv::Status], :void
	attach_function :safe_primitiv_Optimizer_reset_gradients, [:pointer, Primitiv::Status], :void
	attach_function :safe_primitiv_Optimizer_update, [:pointer, Primitiv::Status], :void
end
