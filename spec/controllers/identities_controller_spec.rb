require 'spec_helper'

describe IdentitiesController do

  describe 'POST #create' do
  	context 'on successful login' do
  	  it 'redirects to :show view'
  	end

  	context 'on uncessful login' do
      it 'renders the :show template'
  	end
  end

  describe 'GET #new' do
  	it 'renders the :new view'
  end

  describe 'GET #edit' do
  	it 'renders the :edit view'
  end

  describe 'GET #show' do
  	it 'renders the :show view'
  end

  describe 'PUT #update' do
  	context 'on successful update' do
  	  it 'edits identity in database'
  	end
  	context 'on uncessessful update' do
  		it 'renders the :edit view'
  		it 'has errors'
  	end
  end

  describe 'DELETE #destroy' do
  	it 'deletes indentity in database'
  end
end
