class Api::V1::BooksController < ApplicationController
  ALLOWED_DATA = %(title description rating).freeze
  def index
    books = Book.all
    render json: books
  end

  def show
    book = Book.find(params[:id])
    render json: book
  end

  def create
    data = json_payload.select { |k| ALLOWED_DATA.include?(k) }
    book = Book.new(data)
    if book.save
      render json: book
    else
      render json: { "error": 'could not create book' }
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
  end
end
