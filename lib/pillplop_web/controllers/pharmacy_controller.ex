defmodule PillplopWeb.PharmacyController do
  use PillplopWeb, :controller
  alias Pillplop.Pharmacy
  alias Pillplop.Repo

  def index(conn, _params) do
    pharmacies = Repo.all(Pharmacy)
    render(conn, "index.html", pharmacies: pharmacies)
  end

  def new(conn, _params) do
    changeset = Pharmacy.changeset(%Pharmacy{}, _params)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pharmacy" => pharmacy_params}) do
    changeset = Pharmacy.changeset(%Pharmacy{}, pharmacy_params)
    case Repo.insert(changeset) do
      {:ok, pharmacy} ->
        conn
        |> put_flash(:info, "Pharmacy created!")
        |> redirect(to: Routes.pharmacy_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
