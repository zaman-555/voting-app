-- init.sql
USE voting_app;

-- Polls table
CREATE TABLE IF NOT EXISTS polls (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP NULL,
  is_active BOOLEAN DEFAULT true
);

-- Poll options table
CREATE TABLE IF NOT EXISTS poll_options (
  id INT AUTO_INCREMENT PRIMARY KEY,
  poll_id INT NOT NULL,
  option_text VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (poll_id) REFERENCES polls(id) ON DELETE CASCADE
);

-- Votes table
CREATE TABLE IF NOT EXISTS votes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  poll_id INT NOT NULL,
  option_id INT NOT NULL,
  voter_ip VARCHAR(45),
  voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (poll_id) REFERENCES polls(id) ON DELETE CASCADE,
  FOREIGN KEY (option_id) REFERENCES poll_options(id) ON DELETE CASCADE,
  INDEX idx_poll_id (poll_id),
  INDEX idx_option_id (option_id),
  INDEX idx_voter_ip (voter_ip, poll_id)
);

-- Insert sample data
INSERT INTO polls (title, description, is_active) VALUES 
('Favorite Programming Language', 'Which programming language do you prefer for web development?', true),
('Best Framework for Frontend', 'What is your favorite frontend framework?', true),
('Remote Work Preference', 'How do you prefer to work?', true),
('Best Code Editor', 'Which code editor do you use most?', true),
('Favorite Database', 'What is your preferred database technology?', true),
('Coffee or Tea?', 'What is your beverage of choice while coding?', true),
('Best Operating System for Development', 'Which OS do you prefer for software development?', true),
('Preferred Testing Framework', 'What testing framework do you prefer?', true);

INSERT INTO poll_options (poll_id, option_text) VALUES
(1, 'JavaScript'), (1, 'Python'), (1, 'Java'), (1, 'Go'), (1, 'TypeScript'),
(2, 'React'), (2, 'Vue'), (2, 'Angular'), (2, 'Svelte'),
(3, 'Fully Remote'), (3, 'Hybrid (2-3 days office)'), (3, 'Full-time Office'), (3, 'Flexible (my choice)'),
(4, 'VS Code'), (4, 'WebStorm'), (4, 'Sublime Text'), (4, 'Vim/Neovim'), (4, 'IntelliJ IDEA'),
(5, 'MySQL'), (5, 'PostgreSQL'), (5, 'MongoDB'), (5, 'Redis'), (5, 'SQLite'),
(6, 'Coffee'), (6, 'Tea'), (6, 'Energy Drinks'), (6, 'Water'), (6, 'None - Pure Focus'),
(7, 'macOS'), (7, 'Linux'), (7, 'Windows'), (7, 'Windows with WSL'),
(8, 'Jest'), (8, 'Mocha'), (8, 'Pytest'), (8, 'JUnit'), (8, 'Cypress');