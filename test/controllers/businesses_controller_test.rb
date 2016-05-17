require 'test_helper'

class BusinessesControllerTest < ActionController::TestCase
  test "should get index " do
    response = get :index
    assert_response :success
    obj = JSON.parse(response.body)
    assert_equal(1, obj["page"])
    assert_equal(50, obj["number_per_page"])
    assert_equal(4, obj["total_count"])

    obj["businesses"].each {
      |business| validate_object(businesses(:"#{business['id']}".to_s.to_sym), business)
    }
  end

  test "should get index 1st page, 2 per page" do
    response = get :index
    assert_response :success
    obj = JSON.parse(response.body)
    assert_equal(1, obj["page"])
    assert_equal(50, obj["number_per_page"])
    assert_equal(4, obj["total_count"])

    obj["businesses"].each {
      |business| validate_object(businesses(:"#{business['id']}".to_s.to_sym), business)
    }
  end

  test "should get index 2nd page, 2 per page" do
    response = get :index, {'page' => 2, 'per' => 2}
    assert_response :success
    obj = JSON.parse(response.body)
    assert_equal("2", obj["page"])
    assert_equal("2", obj["number_per_page"])
    assert_equal(4, obj["total_count"])

    obj["businesses"].each {
      |business| validate_object(businesses(:"#{business['id']}".to_s.to_sym), business)
    }
  end

  test "should get index 2nd page, 3 per page" do
    response = get :index, {'page' => 2, 'per' => 3}
    assert_response :success
    obj = JSON.parse(response.body)
    assert_equal("2", obj["page"])
    assert_equal("3", obj["number_per_page"])
    assert_equal(4, obj["total_count"])
    assert_equal(1, obj["businesses"].size)
    obj["businesses"].each {
      |business| validate_object(businesses(:"#{business['id']}".to_s.to_sym), business)
    }
  end

  test "should get show" do
    response = get :show, id: 0
    assert_response :success

    obj = JSON.parse(response.body)

    validate_object(businesses(:"#{0}"), obj)
  end

  test "should not get show" do
    get :show, id: -1
    assert_response :not_found
  end

  private
    def validate_object(obj1, obj2)
      assert_equal(obj1.id, obj2["id"])
      assert_equal(obj1.uuid, obj2["uuid"])
      assert_equal(obj1.name, obj2["name"])
      assert_equal(obj1.address, obj2["address"])
      assert_equal(obj1.address2, obj2["address2"])
      assert_equal(obj1.city, obj2["city"])
      assert_equal(obj1.state, obj2["state"])
      assert_equal(obj1.zip, obj2["zip"])
      assert_equal(obj1.country, obj2["country"])
      assert_equal(obj1.phone, obj2["phone"])
      assert_equal(obj1.website, obj2["website"])
      assert_equal(obj1.created_at, obj2["created_at"])
    end
end
