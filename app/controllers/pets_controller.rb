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

    if params[:pet] == nil && !params["owner_name"].empty?
      @pet = Pet.create(name: params[:pet_name])
      @new_owner = Owner.create(name: params[:owner_name])
      binding.pry
      @new_owner.pets << @pet
      @pet.owner_id = @new_owner.id
    else
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:pet])
    end
    binding.pry
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
