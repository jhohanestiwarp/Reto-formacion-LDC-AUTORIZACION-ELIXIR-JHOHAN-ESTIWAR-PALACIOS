defmodule NameProject.ApplicationTest do
  use ExUnit.Case
  doctest NameProject.Application
  alias NameProject.Config.{ConfigHolder, AppConfig}

  test "test childrens" do
    assert NameProject.Application.env_children(:test, %AppConfig{}) == []
  end

  setup do
    if :ets.info(:name_project_config) == :undefined do
      :ets.new(:name_project_config, [:public, :named_table, read_concurrency: true])
    end

    :ets.delete_all_objects(:name_project_config)
    :ok
  end

  test "conf/0 returns the current config when it exists" do
    config = %AppConfig{env: :test, enable_server: true, http_port: 8083}

    :ets.insert(:name_project_config, {:config, config})

    assert ConfigHolder.conf() == config
  end

  test "get!/1 raises an error when the key does not exist" do
    :ets.delete_all_objects(:name_project_config)

    assert_raise RuntimeError, "Config with key :nonexistent_key not found", fn ->
      ConfigHolder.get!(:nonexistent_key)
    end
  end
end
