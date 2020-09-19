require_relative "../quadrocopter.rb"
RSpec.describe QueadrocopterPath do
  describe "#safe?" do
    subject(:quadrocopter_path) { described_class.new(transmitters: transmitters, start_point: start, end_point: destination).safe? }
    context "with available path" do
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
    end
  end
end
