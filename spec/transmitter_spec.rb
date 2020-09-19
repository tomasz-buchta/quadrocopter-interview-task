require_relative "../quadrocopter.rb"

RSpec.describe Transmitter do
  let(:transmitter_a) { Transmitter.new(index: 1, x: 0, y: 0, power: 1) }
  let(:transmitter_b) { Transmitter.new(index: 2, x: 5, y: 5, power: 1) }
  describe "#distance" do
    subject { transmitter_a.distance(x: transmitter_b.x, y: transmitter_b.y) }
    it { is_expected.to be_within(0.1).of(7.071) }
  end
  describe "#can_reach?" do
    subject { transmitter_a.adjacent?(transmitter_b) }
    it { is_expected.to eq(false) }
    context "adjacent transmitters" do
      let(:transmitter_a) { Transmitter.new(index: 1, x: 0, y: 0, power: 1) }
      let(:transmitter_b) { Transmitter.new(index: 2, x: 1, y: 0, power: 1) }
      it { is_expected.to eq(true) }
    end
  end
  describe "#belongs?" do
    let(:x) { 0 }
    let(:y) { 0 }
    subject { transmitter_a.belongs?(x: x, y: y) }
    it { is_expected.to eq(true) }
    context "on the edge" do
      let(:x) { 1 }
      it { is_expected.to eq(true) }
    end
    context "outside" do
      let(:x) { 1 }
      let(:y) { 1 }
      it { is_expected.to eq(false) }
    end
  end
end
