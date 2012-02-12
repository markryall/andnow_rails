require_relative '../spec_helper'

describe SessionsController do
  let(:session) { mock_model Session }
  let(:user) { mock_model User }

  before do
    session.stub! :user=
    session.stub!(:user).and_return user
    session.stub!(:save).and_return true
    user.stub!(:id).and_return 1
  end

  it 'should strip description from create and update' do
    Session.should_receive(:new).with('description' => 'desc').and_return session
    post :create, session: {description: '  desc  '}
  end

  it 'should delete any matching existing sessions' do
    controller.should_receive(:current_user).and_return user
    relation = stub 'relation'
    Session.should_receive(:where).with([
      'description = ? AND start_time = ? AND user_id = ?',
      'desc',
      100,
      1]).and_return relation
    relation.should_receive :delete_all
    post :create, session: {description: 'desc', start_time: '100'}
  end
end
