require 'ffi'
require "./status"
require "./optimizer"

module Primitiv
	module Optimizers
		extend FFI::Library
		ffi_lib "primitiv_c"

		class SGD < Primitiv::Optimizer
			def self.release(ptr)
				status = Primitiv::Status.new
				Primitiv::Optimizers::safe_primitiv_SGD_delete(ptr, status)
				status.into_result
			end

			def initialize(eta = 0.1)
				raise ArgumentError if not eta.is_a?(Float)
				status = Primitiv::Status.new
				ptr = Primitiv::Optimizers::safe_primitiv_SGD_new(eta, status)
				status.into_result

				super ptr
			end

			def eta
				status = Primitiv::Status.new
				val = Primitiv::Optimizers::safe_primitiv_SGD_eta(self, status)
				status.into_result

				return val
			end
		end

		private
		attach_function :safe_primitiv_SGD_new, [:float, Primitiv::Status], :pointer
		attach_function :safe_primitiv_SGD_delete,
			[Primitiv::Optimizers::SGD, Primitiv::Status], :void
		attach_function :safe_primitiv_SGD_eta,
			[Primitiv::Optimizers::SGD, Primitiv::Status], :float
	end
end
