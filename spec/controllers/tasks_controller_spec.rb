# spec/controllers/tasks_controller_spec.rb
require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before do
    # Mocking the current_user method
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'renders all tasks in JSON' do
      create_list(:task, 2, user: user)
      get :index
      expect(response).to have_http_status(:success)
      tasks = JSON.parse(response.body)['tasks']
      expect(tasks.size).to eq(2)
      expect(tasks.first).to have_key('id')
      expect(tasks.first).to have_key('content')
      expect(tasks.first).to have_key('completed')
      expect(tasks.first).to have_key('created_at')
      expect(tasks.first).to have_key('updated_at')
    end
  end

  describe 'GET #index_by_current_user' do
    it 'renders all tasks of current user in JSON' do
      create_list(:task, 2, user: user)
      get :index_by_current_user
      expect(response).to have_http_status(:success)
      tasks = JSON.parse(response.body)['tasks']
      expect(tasks.size).to eq(2)
      expect(tasks.first).to have_key('id')
      expect(tasks.first).to have_key('content')
      expect(tasks.first).to have_key('completed')
      expect(tasks.first).to have_key('created_at')
      expect(tasks.first).to have_key('updated_at')
    end
  end

  describe 'POST #create' do
    it 'renders newly created task in JSON' do
      post :create, params: { task: { content: 'New Task', completed: false } }
      expect(response).to have_http_status(:created)
      task_response = JSON.parse(response.body)['task']
      expect(task_response).to have_key('id')
      expect(task_response['content']).to eq('New Task')
      expect(task_response['completed']).to be(false)
    end
  end

  describe 'DELETE #destroy' do
    it 'renders success status' do
      delete :destroy, params: { id: task.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq('success' => true)
      expect(Task.count).to eq(0)
    end
  end

  describe 'PUT #mark_complete' do
    it 'renders modified task' do
      put :mark_complete, params: { id: task.id }
      expect(response).to have_http_status(:success)
      task_response = JSON.parse(response.body)['task']
      expect(task_response['completed']).to be(true)
    end
  end

  describe 'PUT #mark_active' do
    it 'renders modified task' do
      task.update(completed: true)
      put :mark_active, params: { id: task.id }
      expect(response).to have_http_status(:success)
      task_response = JSON.parse(response.body)['task']
      expect(task_response['completed']).to be(false)
    end
  end
end
