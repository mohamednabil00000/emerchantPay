# frozen_string_literal: true

RSpec.shared_examples 'create transaction service' do
  describe '#create' do
    context '#success' do
      it 'new authorize transaction record created' do
        expect do
          result = subject.create
          expect(result).to be_successful
        end.to change { transaction.count }.by(1)
      end

      it 'when status does not exist' do
        expect do
          result = described_class.new(args.except(:status)).create
          expect(result).to be_successful
          expect(result.attributes[:transaction].status).to eq 'error'
        end.to change { transaction.count }.by(1)
      end
    end

    context '#failure' do
      it 'when uuid is in a wrong format' do
        args[:uuid] = '122324'
        expect do
          result = subject.create
          expect(result).not_to be_successful
        end.not_to(change { transaction.count })
      end
    end
  end
end
