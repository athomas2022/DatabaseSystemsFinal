CREATE USER 'Spongebob';
CREATE USER 'Squidward';

# Spongebob's (admin) privileges
GRANT ALL PRIVILEGES ON categories TO 'Spongebob';
GRANT ALL PRIVILEGES ON companydata TO 'Spongebob';
GRANT ALL PRIVILEGES ON customers TO 'Spongebob';
GRANT ALL PRIVILEGES ON employees TO 'Spongebob';
GRANT ALL PRIVILEGES ON orders TO 'Spongebob';
GRANT ALL PRIVILEGES ON products TO 'Spongebob';

# Squidward (read only) privileges
GRANT ALL PRIVILEGES ON suppliers TO 'Spongebob';
GRANT SELECT ON categories TO 'Squidward';
GRANT SELECT ON companydata TO 'Squidward';
GRANT SELECT ON customers TO 'Squidward';
GRANT SELECT ON employees TO 'Squidward';
GRANT SELECT ON orders TO 'Squidward';
GRANT SELECT ON products TO 'Squidward';
GRANT SELECT ON suppliers TO 'Squidward';
FLUSH PRIVILEGES;

# Check grants
SHOW GRANTS FOR 'Spongebob';
SHOW GRANTS FOR 'Squidward';