class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    if params[:search_choice] == "last_week"
      params[:start_date] = firstDay
      params[:end_date] = lastDay
      if params[:filter_list] != ""
        @items = Item.where(transaction_date: (params[:start_date]..params[:end_date]), category: params[:filter_list])
      else
        @items = Item.where(transaction_date: (params[:start_date]..params[:end_date]))
      end
    elsif params[:search_choice] == "view_month"
      date = Date.parse(params[:month_list])
      
      while date.day != 1
        date = date.prev_day
      end
      
      params[:start_date] = date
      
      while date.next_day.month != date.next_month.month
        date = date.next_day
      end
      
      params[:end_date] = date
      if params[:filter_list] != ""
        @items = Item.where(transaction_date: (params[:start_date]..params[:end_date]), category: params[:filter_list]).order(transaction_date: :desc)
      else
        @items = Item.where(transaction_date: (params[:start_date]..params[:end_date])).order(transaction_date: :desc)
      end
    elsif params[:search_choice] == "date_range"
      if params[:filter_list] != ""
        @items = Item.where(transaction_date: (params[:start_date]..params[:end_date]), category: params[:filter_list]).order(transaction_date: :desc)
      else
        @items = Item.where(transaction_date: (params[:start_date]..params[:end_date])).order(transaction_date: :desc)
      end
    else
      if params[:filter_list] == nil || params[:filter_list] == ""
        @items = Item.all.order(transaction_date: :desc)
      else
        @items = Item.where(category: params[:filter_list]).order(transaction_date: :desc)
      end
    end
    @debitTotal = @items.where(debit:true).sum(:amount)
    @creditTotal = @items.where(debit:false).sum(:amount)
    @categories = Item.select(:category).distinct
    $months = pastMonths()
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @categories = Item.select(:category).distinct
    @subcategories = Item.select(:subcategory).distinct
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @categories = Item.select(:category).distinct
    @subcategories = Item.select(:subcategory).distinct
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_url, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { redirect_to new_item_path }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_url, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { redirect_to edit_item_path }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:description, :amount, :debit, :category, :subcategory, :transaction_date)
    end
    
    def firstDay
      today = Date.today
      day = today.cwday
      if day == 7
        day = 0
      end
      return today - day - 7
    end
    
    def lastDay
      today = Date.today
      day = today.cwday
      if day == 7
        day = 0
      end
      return today - day - 1
    end

    def pastMonths
      date = Date.today.prev_month
      months = {}
      until months.length == 12
        if date.month < 10
          month = "0" + date.month.to_s
        else
          month = date.month
        end
        months[date.year.to_s + "-" + month.to_s] = date
        date = date.prev_month
      end
      return months
    end
end
