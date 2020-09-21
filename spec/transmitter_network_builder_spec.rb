require_relative "../quadrocopter.rb"

RSpec.describe TransmitterNetworkBuilder do
  let(:transmitters) {
    [
      Transmitter.new(index: 1, x: 0, y: 0, power: 1),
      Transmitter.new(index: 2, x: 1, y: 0, power: 2),
      Transmitter.new(index: 3, x: 3, y: 3, power: 2)
    ]
  }
  subject { described_class.new.build(transmitters) }

  it { is_expected.to be_a(RGL::AdjacencyGraph) }
  it { expect(subject.vertices).to eq([1,2,3]) }
  it { expect(subject.edges.sort.to_s).to eq("[(1-2), (2-3)]") }
end
