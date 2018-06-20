class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    puts params
    binding.pry
    if params[:owner_id] == nil && params["owner_name"].empty?
      @pet = Pet.create(name: params[:pet_name])
      @new_owner = Owner.create(params[:owner_name])
      @new_owner.pets << @pet
      @pet.owner_id = @new_owner.id
      binding.pry
    else
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by_id(@pet.owner_id)
    erb :'/pets/show'
  end

  post '/pets/:id' do
    puts params

    @pet = Pet.find(params[:id])
      @pet.update(params["pet"])
      if !params["owner"]["name"].empty?
        @pet.owners << Owner.create(name: params["owner"]["name"])
      end
    redirect to "pets/#{@pet.id}"
  end
end
