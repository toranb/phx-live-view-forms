defmodule Formz.UserForm do
  defstruct name: nil, email: nil, password: nil, confirm_password: nil, agree: false

  def new() do
    %__MODULE__{}
  end
end
