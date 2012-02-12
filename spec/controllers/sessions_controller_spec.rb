require_relative '../spec_helper'

describe SessionsController do
  let(:session) { mock_model Session }

  before do
    session.stub! :user=
    session.stub!(:save).and_return true
  end

  it 'should strip description from create and update' do
    Session.should_receive(:new).with('description' => 'desc').and_return session
    post :create, session: {description: '  desc  '}
  end
end
