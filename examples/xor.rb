# coding: utf-8

require './primitiv'

F = Primitiv::Functions
I = Primitiv::Initializers
O = Primitiv::Optimizers

include Primitiv

if __FILE__ == $0

	dev = Devices::Naive.new
	Device::set_default dev

	g = Graph.new
	Graph::set_default g

	pw1 = Parameter.new([8, 2], I::XavierUniform.new)
	pb1 = Parameter.new([8], I::Constant.new(0))
	pw2 = Parameter.new([1, 8], I::XavierUniform.new)
	pb2 = Parameter.new([], I::Constant.new(0))

	optimizer = O::SGD.new 0.1
	optimizer.add_parameter(pw1)
	optimizer.add_parameter(pb1)
	optimizer.add_parameter(pw2)
	optimizer.add_parameter(pb2)

	input_data = [
		 1,  1,
		 1, -1,
		-1,  1,
		-1, -1
	]

	output_data = [
		 1,
		-1,
		-1,
		 1
	]

	for i in 0..9
		g.clear

		x_shape = Shape.new([2], 4)
		x = F::input(x_shape, input_data)
		w1 = F::parameter(pw1)
		b1 = F::parameter(pb1)
		w2 = F::parameter(pw2)
		b2 = F::parameter(pb2)
		h = F::add(F::matmul(w1, x), b1)
		h = F::tanh(h)
		y = F::add(F::matmul(w2, h), b2)

		y_val = y.to_a
		puts "epoch #{i}"
		for j in 0..3
			puts "\t[#{j}]: #{y_val[j]}"
		end

		t_shape = Shape.new([], 4)
		t = F::input(t_shape, output_data)
		diff = F::subtract(t, y)
		loss = F::Batch::mean(F::multiply(diff, diff))

		puts "\tloss: #{loss.to_f}"

		optimizer.reset_gradients
		loss.backward
		optimizer.update
	end

end
