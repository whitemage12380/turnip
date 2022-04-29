class DefaultNameToCharacters < ActiveRecord::Migration[6.1]
  def up
    connection.execute(%q(
      CREATE OR REPLACE FUNCTION trg_default_first_name()
        RETURNS trigger
        LANGUAGE plpgsql AS
      $func$
      BEGIN
        IF NEW.first_name IS NULL THEN
          NEW.first_name := 'Anonymous' || NEW.id;
        END IF;
        RETURN NEW;
      END
      $func$;
      CREATE TRIGGER default_first_name
      BEFORE INSERT ON characters
      FOR EACH ROW
      EXECUTE PROCEDURE trg_default_first_name();
    ))
  end
  def down
    connection.execute(%q(
      DROP TRIGGER IF EXISTS default_first_name ON characters;
      DROP FUNCTION trg_default_first_name();
    ))
  end
end
