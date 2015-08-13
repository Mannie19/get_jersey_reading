class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    
    @book = GoogleBooks.search(Book.first.isbn, { api_key: 'AIzaSyBOnVO64hRZ-18i0pqXBIQ-2BT7iK9_5qc'} )
    @top = @book.first
    @thumb = @top.image_link
        
  end


  # GET /books/1
  # GET /books/1.json
  def show
    @book_link = @book.link
    @books = GoogleBooks.search(@book.isbn) # yields a collection of one result
    @book_show = @books.first # the one result
    @thumb = @book_show.image_link(:zoom => 4)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)


      if @book.save
        redirect_to @book
      else
        render :new
      end
  
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book}
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:link, :isbn, :image_link, :title, :description)
    end
end
