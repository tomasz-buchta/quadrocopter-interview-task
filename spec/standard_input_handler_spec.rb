require_relative "../standard_input_handler"
require_relative "../quadrocopter"

describe StandardInputHandler do
  let(:dummy_solution_class) { class_double(QueadrocopterPath)}
  let(:instance) { described_class.new }
  subject(:call) { instance.call(dummy_solution_class) }
  before do
    allow(instance).to receive(:gets).and_return(
      "3", # Transmitter count
      "6 11 4", # Transmitter 1
      "8 17 3", # Transmitter 2
      "19 19 2", # Transmitter 3
      "10 19", # Start point
      "19 14" # End point
    )
  end
  let(:solution_params) do
    {
      transmitters: [
        {x: 6, y: 11, power: 4},
        {x: 8, y: 17, power: 3},
        {x: 19, y: 19, power: 2},
      ],
      start_point: {x: 10, y: 19},
      end_point: {x: 19, y: 14}
    }
  end
  let(:result) { true }
  it "Initializes the solution with proper params" do
    expect(dummy_solution_class).to receive(:new).with(**solution_params).and_return(instance_double(QueadrocopterPath, safe?: result))
    subject
  end
  describe "output" do
    before { allow(dummy_solution_class).to receive(:new).with(**solution_params).and_return(instance_double(QueadrocopterPath, safe?: result))}
    it "Outputs the result" do
      expect{ subject }.to output("Give transmitter count\nInput trasmitters one in line, format: x y power\nInput start_point\npath is safe\n").to_stdout
    end
    context "with unsafe path" do
      let(:result) { false}
      it do
      expect{ subject }
        .to output("Give transmitter count\nInput trasmitters one in line, format: x y power\nInput start_point\nthere is no safe route\n").to_stdout

      end
    end
  end
end
