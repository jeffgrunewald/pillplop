defmodule PillplopWeb.PharmacyController do
  use PillplopWeb, :controller
  alias Pillplop.Pharmacy
  alias Pillplop.Repo
  alias Pillplop.Auth.Guardian

  def index(conn, _params) do
    pharmacies = Repo.all(Pharmacy)
    render(conn, "index.html", pharmacies: pharmacies)
  end

  def new(conn, params) do
    changeset = Pharmacy.changeset(%Pharmacy{}, params)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pharmacy" => pharmacy_params}) do
    changeset = Pharmacy.registration_changeset(%Pharmacy{}, pharmacy_params)
    case Repo.insert(changeset) do
      {:ok, pharmacy} ->
        conn
        |> Guardian.Plug.sign_in(pharmacy)
        |> put_flash(:info, "Pharmacy created!")
        |> redirect(to: Routes.order_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id} = params) do
    pharmacy = Repo.get(Pharmacy, id)
    changeset = Pharmacy.changeset(pharmacy, params)
    cond do
      pharmacy == Guardian.Plug.current_resource(conn) ->
        conn
        |> render("show.html", pharmacy: pharmacy, changeset: changeset)
      :error ->
        conn
        |> put_flash(:info, "Didn't use the magic word")
        |> redirect(to: Routes.pharmacy_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "pharmacy" => params}) do
    pharmacy = Repo.get(Pharmacy, id)
    changeset = Pharmacy.registration_changeset(pharmacy, params)
    cond do
      pharmacy == Guardian.Plug.current_resource(conn) ->
        case Repo.update(changeset) do
          {:ok, _pharmacy} ->
            conn
            |> put_flash(:info, "Pharmacy updated")
            |> redirect(to: Routes.pharmacy_path(conn, :index))
          {:error, changeset} ->
            conn
            |> render("show.html", pharmacy: pharmacy, changeset: changeset)
        end
      :error ->
        conn
        |> put_flash(:info, "Tisk tisk")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    pharmacy = Repo.get(Pharmacy, id)

    cond do
      pharmacy == Guardian.Plug.current_resource(conn) ->
        case Repo.delete(pharmacy) do
          {:ok, _pharmacy} ->
            conn
            |> Guardian.Plug.sign_out
            |> put_flash(:info, "Account deleted; sorry to see you go :(")
            |> redirect(to: Routes.page_path(conn, :index))
          {:error, _} ->
            conn
            |> render("show.html", pharmacy: pharmacy)
        end
    end
  end
end
