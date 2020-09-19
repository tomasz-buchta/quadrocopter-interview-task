require_relative "../quadrocopter.rb"
RSpec.describe QueadrocopterPath do
  describe "#safe?" do
    subject(:quadrocopter_path) { described_class.new(transmitters: transmitters, start_point: start, end_point: destination).safe? }
    let(:start)       { {x: 10, y: 19} }
    let(:destination) { {x: 19, y: 14} }
    let(:transmitters) {
      [
        { x: 6, y: 11, power: 4 },
        { x: 8, y: 17, power: 3 },
        { x: 19, y: 19, power: 2 },
        { x: 19, y: 11, power: 4 },
        { x: 15, y: 7, power: 6 },
        { x: 12, y: 19, power: 4 }
      ]
    }
    it { is_expected.to eq(true) }
    context "without available path" do
      let(:transmitters) {
        [
          { x: 1, y: 1, power: 4 },
          { x: 100, y: 100, power: 10 }
        ]
      }
      let(:start)       { {x: 1, y: 1} }
      let(:destination) { {x: 100, y: 100} }
      it { is_expected.to eq(false) }
    end
    context "with single transmitter" do
      let(:start)       { {x: 10, y: 10} }
      let(:destination) { {x: 12, y: 12} }
      let(:transmitters) {
        [
          { x: 10, y: 10, power: 4 },
        ]
      }
      it { is_expected.to eq(true) }
    end
    context "without any transmitters" do
      let(:transmitters) { [] }
      it { is_expected.to eq(false) }
    end

    context "when start point is out of transmitter range" do
      let(:start)       { {x: 100, y: 100} }
      it { is_expected.to eq(false) }
    end

    context "when destination point is out of transmitter range" do
      let(:destination)       { {x: 100, y: 100} }
      it { is_expected.to eq(false) }
    end
  end
end
