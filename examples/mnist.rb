# coding: utf-8

require './primitiv'
F = Primitiv::Functions
I = Primitiv::Initializers
O = Primitiv::Optimizers
include Primitiv

NUM_TRAIN_SAMPLES = 60000
NUM_TEST_SAMPLES = 10000
NUM_INPUT_UNITS = 28 * 28
NUM_HIDDEN_UNITS = 800
NUM_OUTPUT_UNITS = 10
BATCH_SIZE = 200
NUM_TRAIN_BATCHS = NUM_TRAIN_SAMPLES / BATCH_SIZE
NUM_TEST_BATCHS = NUM_TEST_SAMPLES / BATCH_SIZE
MAX_EPOCH = 100

def load_images(path, n)
	data = nil
	File.open(path, "r") do |ifs|
		ifs.seek(16)
		data = Array.new(n) do
			ifs.read(28*28).unpack('C*')
		end
	end

	n.times do |i|
		(data[i].size).times do |j|
			data[i][j] /= 255.0
		end
	end

	return data
end

def load_labels(path, n)
	File.open(path, "r") do |ifs|
		ifs.seek(8)
		ifs.read(n).unpack('C*')
	end
end

if __FILE__ == $0

	train_inputs = load_images("./examples/mnist/data/train-images-idx3-ubyte", NUM_TRAIN_SAMPLES)
	train_labels = load_labels("./examples/mnist/data/train-labels-idx1-ubyte", NUM_TRAIN_SAMPLES)
	test_inputs = load_images("./examples/mnist/data/t10k-images-idx3-ubyte", NUM_TEST_SAMPLES)
	test_labels = load_labels("./examples/mnist/data/t10k-labels-idx1-ubyte", NUM_TEST_SAMPLES)

	# dev = Devices::Naive.new
	dev = Devices::CUDA.new 0
	Device::set_default dev
	g = Graph.new
	Graph::set_default g

	$pw1 = Parameter.new([NUM_HIDDEN_UNITS, NUM_INPUT_UNITS], I::XavierUniform.new)
	$pb1 = Parameter.new([NUM_HIDDEN_UNITS], I::Constant.new(0))
	$pw2 = Parameter.new([NUM_OUTPUT_UNITS, NUM_HIDDEN_UNITS], I::XavierUniform.new)
	$pb2 = Parameter.new([NUM_OUTPUT_UNITS], I::Constant.new(0))

	optimizer = O::SGD.new 0.5
	optimizer.add_parameter($pw1)
	optimizer.add_parameter($pb1)
	optimizer.add_parameter($pw2)
	optimizer.add_parameter($pb2)

	def make_graph(inputs, train)
		# Store input values.
		x_shape = Shape.new([NUM_INPUT_UNITS], BATCH_SIZE)
		x = F::input(x_shape, inputs)
		# Caluculates the hidden layer
		w1 = F::parameter($pw1)
		b1 = F::parameter($pb1)
		h = F::relu(F::add(F::matmul(w1, x), b1))
		# dropout
		h = F::dropout(h, 0.5, train)
		# Caluclates the output layer
		w2 = F::parameter($pw2)
		b2 = F::parameter($pb2)
		return F::add(F::matmul(w2, h), b2)
	end

	ids = (0..NUM_TRAIN_SAMPLES-1).to_a

	MAX_EPOCH.times do |epoch|
		puts "epoch: #{epoch + 1}"

		ids.shuffle!
		sum_loss = 0
		NUM_TRAIN_BATCHS.times do |batch|
			print "\r\ttrain: #{batch+1}/#{NUM_TRAIN_BATCHS}"

			inputs = Array.new(BATCH_SIZE)
			labels = Array.new(BATCH_SIZE)
			BATCH_SIZE.times do |i|
				id = ids[i + batch * BATCH_SIZE]
				inputs[i] = train_inputs[id]
				labels[i] = train_labels[id]
			end
			inputs.flatten!

			g.clear
			y = make_graph(inputs, true)
			loss = F::softmax_cross_entropy(y, labels, 0)
			avg_loss = F::Batch::mean(loss)
			sum_loss += avg_loss.to_f * BATCH_SIZE

			optimizer.reset_gradients
			avg_loss.backward
			optimizer.update
		end
		puts "\tloss: #{sum_loss/NUM_TRAIN_SAMPLES}"

		match = 0
		NUM_TEST_BATCHS.times do |batch|
			print "\r\ttest: #{batch+1}/#{NUM_TEST_BATCHS}"

			inputs = Array.new(BATCH_SIZE)
			labels = Array.new(BATCH_SIZE)
			BATCH_SIZE.times do |i|
				id = i + batch * BATCH_SIZE
				inputs[i] = test_inputs[id]
				labels[i] = test_labels[id]
			end
			inputs.flatten!

			g.clear
			y = make_graph(inputs, false)

			y_val = y.to_a
			BATCH_SIZE.times do |i|
				maxval = -1e10
				argmax = -1
				NUM_OUTPUT_UNITS.times do |j|
					v = y_val[j + i * NUM_OUTPUT_UNITS]
					if v > maxval
						maxval = v
						argmax = j
					end
				end
				if argmax == test_labels[i + batch * BATCH_SIZE]
					match += 1
				end
			end
		end

		accuracy = 100.0 * match / NUM_TEST_SAMPLES
		puts "\taccuracy: #{accuracy}"
	end

end
