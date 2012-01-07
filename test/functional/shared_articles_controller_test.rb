require 'test_helper'

class SharedArticlesControllerTest < ActionController::TestCase
  setup do
    @shared_article = shared_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shared_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shared_article" do
    assert_difference('SharedArticle.count') do
      post :create, shared_article: @shared_article.attributes
    end

    assert_redirected_to shared_article_path(assigns(:shared_article))
  end

  test "should show shared_article" do
    get :show, id: @shared_article.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shared_article.to_param
    assert_response :success
  end

  test "should update shared_article" do
    put :update, id: @shared_article.to_param, shared_article: @shared_article.attributes
    assert_redirected_to shared_article_path(assigns(:shared_article))
  end

  test "should destroy shared_article" do
    assert_difference('SharedArticle.count', -1) do
      delete :destroy, id: @shared_article.to_param
    end

    assert_redirected_to shared_articles_path
  end
end
