PRAGMA foreign_keys = ON;

-- Providers
INSERT INTO Provider (provider_id, name, notes) VALUES
(1, 'Microsoft', NULL),
(2, 'Microsoft Learn', NULL),
(3, 'AWS', NULL);

-- Categories (lo justo para PR, pero correcto)
INSERT INTO Category (category_id, name, notes) VALUES
(1, 'Data', NULL),
(2, 'Machine Learning', NULL),
(3, 'Cloud Development', NULL),
(4, 'AI Engineering', NULL),
(5, 'Power Platform', NULL);

-- Learning levels
INSERT INTO LearningLevel (learning_level_id, name, notes) VALUES
(1, 'beginner', NULL),
(2, 'intermediate', NULL);

-- Certification tiers
INSERT INTO CertificationTier (cert_tier_id, name, notes) VALUES
(1, 'fundamentals', NULL),
(2, 'associate', NULL);

-- Visibility
INSERT INTO Visibility (visibility_id, name, notes) VALUES
(1, 'PUBLIC', NULL),
(2, 'PRIVATE', NULL);

-- Study status
INSERT INTO StudyStatus (status_id, name, notes) VALUES
(1, 'DONE', NULL),
(2, 'PLANNED', NULL);

-- Practice result types (empty usable catalog)
INSERT INTO PracticeResultType (result_type_id, name, notes) VALUES
(1, 'applied-skill', NULL);

-- Attempt status
INSERT INTO AttemptStatus (attempt_status_id, name, notes) VALUES
(1, 'pass', NULL),
(2, 'fail', NULL),
(3, 'scheduled', NULL);

-- Tags (mínimo útil, ampliable luego)
INSERT INTO Tag (tag_id, name, description) VALUES
(1, 'Azure', NULL),
(2, 'SQL', NULL),
(3, 'NoSQL', NULL),
(4, 'Analytics', NULL),
(5, 'Python', NULL),
(6, 'Regression', NULL),
(7, 'Classification', NULL),
(8, 'Clustering', NULL),
(9, 'Deep Learning', NULL),
(10,'Evaluation', NULL);

-- Topics: DP-900 (PUBLIC)
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(1, 'Explore core data concepts', 2, 1, 1, 1, '2026-02-09 00:00:00'),
(2, 'Explore relational data in Azure', 2, 1, 1, 1, '2026-02-09 00:00:00'),
(3, 'Explore non-relational data in Azure', 2, 1, 1, 1, '2026-02-10 00:00:00'),
(4, 'Explore analytics workloads in Azure', 2, 1, 1, 1, '2026-02-10 00:00:00');

-- Topics: Create Machine Learning Models (PUBLIC)
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(5, 'Explore and analyze data with Python', 2, 2, 2, 1, '2026-02-11 00:00:00'),
(6, 'Train and evaluate regression models', 2, 2, 2, 1, '2026-02-11 00:00:00'),
(7, 'Train and evaluate classification models', 2, 2, 2, 1, '2026-02-12 00:00:00'),
(8, 'Train and evaluate clustering models', 2, 2, 2, 1, '2026-02-12 00:00:00'),
(9, 'Train and evaluate deep learning models', 2, 2, 2, 1, '2026-02-13 00:00:00');

-- Topic tags
INSERT INTO TopicTag (topic_id, tag_id) VALUES
(1, 1),
(2, 1), (2, 2),
(3, 1), (3, 3),
(4, 1), (4, 4),
(5, 5),
(6, 5), (6, 6), (6, 10),
(7, 5), (7, 7), (7, 10),
(8, 5), (8, 8), (8, 10),
(9, 5), (9, 9), (9, 10);

-- Study sessions (reales)
INSERT INTO StudySession
(session_id, topic_id, started_at, ended_at, duration_minutes, difficulty, energy, notes, visibility_id, status_id)
VALUES
(1, 1, '2026-02-09 22:00:00', '2026-02-09 22:45:00', 45, 2, 3, NULL, 1, 1),
(2, 2, '2026-02-10 19:00:00', '2026-02-10 20:45:00', 105, 3, 3, NULL, 1, 1),
(3, 3, '2026-02-11 19:30:00', '2026-02-11 21:15:00', 105, 3, 3, NULL, 1, 1),
(4, 4, '2026-02-12 21:00:00', '2026-02-12 23:30:00', 150, 3, 2, NULL, 1, 1),

(5, 5, '2026-02-13 15:30:00', '2026-02-13 16:30:00', 60, 4, 3, NULL, 1, 1),
(6, 6, '2026-02-13 16:30:00', '2026-02-13 17:45:00', 75, 4, 3, NULL, 1, 1),
(7, 7, '2026-02-15 12:15:00', '2026-02-15 13:30:00', 75, 4, 3, NULL, 1, 1),
(8, 8, '2026-02-16 19:00:00', '2026-02-16 20:00:00', 60, 3, 4, NULL, 1, 1),
(9, 9, '2026-02-16 20:00:00', '2026-02-16 21:00:00', 60, 5, 2, NULL, 1, 1);

-- Certifications
INSERT INTO Certification
(certification_id, code, name, provider_id, category_id, cert_tier_id, official_url)
VALUES
(1, 'PL-400', 'Microsoft Certified: Power Platform Developer Associate', 1, 5, 2, NULL),
(2, 'AZ-204', 'Microsoft Certified: Azure Developer Associate', 1, 3, 2, NULL),
(3, 'DVA-C02', 'AWS Certified Developer – Associate', 3, 3, 2, NULL),
(4, 'AI-102', 'Microsoft Certified: Azure AI Engineer Associate', 1, 4, 2, NULL);