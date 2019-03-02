defmodule Pillplop.SalesTest do
  use Pillplop.DataCase

  alias Pillplop.Sales

  describe "orders" do
    alias Pillplop.Sales.Order

    @valid_attrs %{location_id: 42, patient_id: 42, prescription_id: 42}
    @update_attrs %{location_id: 43, patient_id: 43, prescription_id: 43}
    @invalid_attrs %{location_id: nil, patient_id: nil, prescription_id: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sales.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Sales.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Sales.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Sales.create_order(@valid_attrs)
      assert order.location_id == 42
      assert order.patient_id == 42
      assert order.prescription_id == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Sales.update_order(order, @update_attrs)
      assert order.location_id == 43
      assert order.patient_id == 43
      assert order.prescription_id == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_order(order, @invalid_attrs)
      assert order == Sales.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Sales.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Sales.change_order(order)
    end
  end

  describe "locations" do
    alias Pillplop.Sales.Location

    @valid_attrs %{latitude: "some latitude", longitude: "some longitude", pharmacy_id: 42}
    @update_attrs %{latitude: "some updated latitude", longitude: "some updated longitude", pharmacy_id: 43}
    @invalid_attrs %{latitude: nil, longitude: nil, pharmacy_id: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sales.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Sales.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Sales.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Sales.create_location(@valid_attrs)
      assert location.latitude == "some latitude"
      assert location.longitude == "some longitude"
      assert location.pharmacy_id == 42
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, %Location{} = location} = Sales.update_location(location, @update_attrs)
      assert location.latitude == "some updated latitude"
      assert location.longitude == "some updated longitude"
      assert location.pharmacy_id == 43
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_location(location, @invalid_attrs)
      assert location == Sales.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Sales.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Sales.change_location(location)
    end
  end
end
