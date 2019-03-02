defmodule Pillplop.ProductsTest do
  use Pillplop.DataCase

  alias Pillplop.Products

  describe "prescriptions" do
    alias Pillplop.Products.Prescription

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def prescription_fixture(attrs \\ %{}) do
      {:ok, prescription} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_prescription()

      prescription
    end

    test "list_prescriptions/0 returns all prescriptions" do
      prescription = prescription_fixture()
      assert Products.list_prescriptions() == [prescription]
    end

    test "get_prescription!/1 returns the prescription with given id" do
      prescription = prescription_fixture()
      assert Products.get_prescription!(prescription.id) == prescription
    end

    test "create_prescription/1 with valid data creates a prescription" do
      assert {:ok, %Prescription{} = prescription} = Products.create_prescription(@valid_attrs)
      assert prescription.name == "some name"
    end

    test "create_prescription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_prescription(@invalid_attrs)
    end

    test "update_prescription/2 with valid data updates the prescription" do
      prescription = prescription_fixture()
      assert {:ok, %Prescription{} = prescription} = Products.update_prescription(prescription, @update_attrs)
      assert prescription.name == "some updated name"
    end

    test "update_prescription/2 with invalid data returns error changeset" do
      prescription = prescription_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_prescription(prescription, @invalid_attrs)
      assert prescription == Products.get_prescription!(prescription.id)
    end

    test "delete_prescription/1 deletes the prescription" do
      prescription = prescription_fixture()
      assert {:ok, %Prescription{}} = Products.delete_prescription(prescription)
      assert_raise Ecto.NoResultsError, fn -> Products.get_prescription!(prescription.id) end
    end

    test "change_prescription/1 returns a prescription changeset" do
      prescription = prescription_fixture()
      assert %Ecto.Changeset{} = Products.change_prescription(prescription)
    end
  end
end
