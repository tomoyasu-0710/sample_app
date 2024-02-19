class ListsController < ApplicationController
  def new
    #Viewへ渡すため渡すためのインスタンス変数にからのModelオブジェクトを生成する
    @list = List.new
  end

  #以下追加
  def create
    #１。＆２データを受け取り新規登録するためのインスタンス作成
    @list = List.new (list_params)
    #データをデータベースに保存するためのsaveメソッド
    if @list.save
      #フラッシュメッセージを定義し、要塞画面にリダイレクト
      flash[:notice] = "投稿に成功しました"
      redirect_to list_path(@list.id)
    else
      #フラッシュメッセージを定義して、new.html.erbを描画する
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
    #list.save
    #redirect_to '/top'
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id]) #データ（レコード）を一件取得
    list.destroy   #データ（レコード）を削除
    redirect_to '/lists'  #投稿一覧画面にリダイレクト
  end

  private
  #ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
