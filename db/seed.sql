PRAGMA foreign_keys = ON;

-- Providers
DELETE FROM Provider;

INSERT INTO Provider (provider_id, name, notes) VALUES
(1, 'Microsoft', NULL),
(2, 'Microsoft Learn', NULL),
(3, 'AWS', NULL);

-- Categories
DELETE FROM Category;

INSERT INTO Category (category_id, name, notes) VALUES
(1, 'Data', NULL),
(2, 'Machine Learning', NULL),
(3, 'Cloud Development', NULL),
(4, 'AI Engineering', NULL),
(5, 'Power Platform', NULL),
(6, 'Natural Language Processing', NULL),
(7, 'Data Analytics', NULL);

-- Learning levels
DELETE FROM LearningLevel;

INSERT INTO LearningLevel (learning_level_id, name, notes) VALUES
(1, 'beginner', NULL),
(2, 'intermediate', NULL);

-- Certification tiers
DELETE FROM CertificationTier;

INSERT INTO CertificationTier (cert_tier_id, name, notes) VALUES
(1, 'fundamentals', NULL),
(2, 'associate', NULL);

-- Visibility
DELETE FROM Visibility;

INSERT INTO Visibility (visibility_id, name, notes) VALUES
(1, 'PUBLIC', NULL),
(2, 'PRIVATE', NULL);

-- Study status
DELETE FROM StudyStatus;

INSERT INTO StudyStatus (status_id, name, notes) VALUES
(1, 'DONE', NULL),
(2, 'PLANNED', NULL);

-- Practice result types
DELETE FROM PracticeResultType;

INSERT INTO PracticeResultType (result_type_id, name, notes) VALUES
(1, 'applied-skill', NULL);

-- Attempt status
DELETE FROM AttemptStatus;

INSERT INTO AttemptStatus (attempt_status_id, name, notes) VALUES
(1, 'pass', NULL),
(2, 'fail', NULL),
(3, 'scheduled', NULL);

-- Tags
DELETE FROM Tag;

INSERT INTO Tag (tag_id, name, description) VALUES
(1,  'Azure', NULL),
(2,  'SQL', NULL),
(3,  'NoSQL', NULL),
(4,  'Analytics', NULL),
(5,  'Python', NULL),
(6,  'Regression', NULL),
(7,  'Classification', NULL),
(8,  'Clustering', NULL),
(9,  'Deep Learning', NULL),
(10, 'Evaluation', NULL),

(11, 'Azure Storage', NULL),
(12, 'Azure Cosmos DB', NULL),
(13, 'Power BI', NULL),
(14, 'Streaming', NULL),

(15, 'NLP', NULL),
(16, 'Azure AI Language', NULL),
(17, 'Question Answering', NULL),
(18, 'CLU', NULL),
(19, 'NER', NULL),
(20, 'Translator', NULL),
(21, 'Speech', NULL),
(22, 'Azure AI Foundry', NULL);

-- Topics
DELETE FROM Topic;

-- -------------------------
-- DP-900 modules (Beginner)
-- Learning path: core data concepts
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(1, 'Explore core data concepts',      2, 1, 1, 1, '2026-02-09 00:00:00'),
(2, 'Explore data roles and services', 2, 1, 1, 1, '2026-02-09 00:00:00');

-- -------------------------
-- DP-900 modules (Beginner)
-- Learning path: relational data
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(3, 'Explore fundamental relational data concepts',  2, 1, 1, 1, '2026-02-10 00:00:00'),
(4, 'Explore relational database services in Azure', 2, 1, 1, 1, '2026-02-10 00:00:00');

-- -------------------------
-- DP-900 modules (Beginner)
-- Learning path: non-relational data
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(5, 'Explore Azure Storage for non-relational data', 2, 1, 1, 1, '2026-02-11 00:00:00'),
(6, 'Explore fundamentals of Azure Cosmos DB',       2, 1, 1, 1, '2026-02-11 00:00:00');

-- -------------------------
-- DP-900 modules (Beginner)
-- Learning path: analytics in Azure
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(7, 'Explore fundamentals of large-scale analytics', 2, 7, 1, 1, '2026-02-12 00:00:00'),
(8, 'Explore fundamentals of real-time analytics',   2, 7, 1, 1, '2026-02-12 00:00:00'),
(9, 'Explore fundamentals of data visualization',    2, 7, 1, 1, '2026-02-12 00:00:00');

-- -------------------------
-- Create machine learning models (Intermediate)
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(10, 'Explore and analyze data with Python',      2, 2, 2, 1, '2026-02-13 00:00:00'),
(11, 'Train and evaluate regression models',      2, 2, 2, 1, '2026-02-15 00:00:00'),
(12, 'Train and evaluate classification models',  2, 2, 2, 1, '2026-02-16 00:00:00'),
(13, 'Train and evaluate clustering models',      2, 2, 2, 1, '2026-02-16 00:00:00'),
(14, 'Train and evaluate deep learning models',   2, 2, 2, 1, '2026-02-16 00:00:00');

-- -------------------------
-- Develop natural language solutions in Azure (Intermediate)
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(15, 'Analyze text with Azure Language',                        2, 6, 2, 1, '2026-02-19 00:00:00'),
(16, 'Create question answering solutions with Azure Language', 2, 6, 2, 1, '2026-02-19 00:00:00'),
(17, 'Build a conversational language understanding model',     2, 6, 2, 1, '2026-02-20 00:00:00'),
(18, 'Create custom text classification solutions',             2, 6, 2, 1, '2026-02-20 00:00:00'),
(19, 'Custom named entity recognition',                         2, 6, 2, 1, '2026-02-21 00:00:00'),
(20, 'Translate text with Azure Translator service',            2, 6, 2, 1, '2026-02-21 00:00:00'),
(21, 'Create speech-enabled apps with Microsoft Foundry',       2, 6, 2, 1, '2026-02-22 00:00:00'),
(22, 'Translate speech with the Azure Speech service',          2, 6, 2, 1, '2026-02-22 00:00:00'),
(23, 'Develop an audio-enabled generative AI application',      2, 6, 2, 1, '2026-02-23 00:00:00'),
(24, 'Develop an Azure AI Voice Live agent',                    2, 6, 2, 1, '2026-02-23 00:00:00');

-- Topic tags
DELETE FROM TopicTag;

-- -------------------------
-- DP-900 tags (Data / Analytics)
-- -------------------------
INSERT INTO TopicTag (topic_id, tag_id) VALUES
(1, 1),
(2, 1),
(3, 1), (3, 2),
(4, 1), (4, 2),
(5, 1), (5, 11),
(6, 1), (6, 3), (6, 12),
(7, 1), (7, 4),
(8, 1), (8, 4), (8, 14),
(9, 1), (9, 4), (9, 13);

-- -------------------------
-- Create ML Models tags
-- -------------------------
INSERT INTO TopicTag (topic_id, tag_id) VALUES
(10, 5),
(11, 5), (11, 6), (11, 10),
(12, 5), (12, 7), (12, 10),
(13, 5), (13, 8), (13, 10),
(14, 5), (14, 9), (14, 10);

-- -------------------------
-- NLP tags
-- -------------------------
INSERT INTO TopicTag (topic_id, tag_id) VALUES
(15, 1), (15, 15), (15, 16),
(16, 1), (16, 15), (16, 16), (16, 17),
(17, 1), (17, 15), (17, 16), (17, 18),
(18, 1), (18, 15), (18, 16), (18, 7),
(19, 1), (19, 15), (19, 16), (19, 19),
(20, 1), (20, 15), (20, 20),
(21, 1), (21, 21), (21, 22),
(22, 1), (22, 21),
(23, 1), (23, 21), (23, 22),
(24, 1), (24, 21), (24, 22);

-- Study sessions

-- -------------------------
-- DONE
-- -------------------------

DELETE FROM StudySession;

INSERT INTO StudySession
(session_id, topic_id, started_at, ended_at, duration_minutes, difficulty, energy, notes, visibility_id, status_id)
VALUES
-- =========================
-- DONE
-- =========================

-- 2026-02-09
(1,  1, '2026-02-09 19:12:00', '2026-02-09 19:49:00', 37, 2, 3, NULL, 1, 1),
(2,  2, '2026-02-09 20:05:00', '2026-02-09 20:27:00', 22, 2, 3, NULL, 1, 1),

-- 2026-02-10
(3,  3, '2026-02-10 19:18:00', '2026-02-10 20:02:00', 44, 3, 3, NULL, 1, 1),
(4,  4, '2026-02-10 20:17:00', '2026-02-10 21:00:00', 43, 3, 3, NULL, 1, 1),

-- 2026-02-11
(5,  5, '2026-02-11 19:41:00', '2026-02-11 20:29:00', 48, 3, 3, NULL, 1, 1),
(6,  6, '2026-02-11 20:44:00', '2026-02-11 21:22:00', 38, 3, 3, NULL, 1, 1),

-- 2026-02-12
(7,  7, '2026-02-12 19:09:00', '2026-02-12 20:00:00', 51, 3, 2, NULL, 1, 1),
(8,  8, '2026-02-12 20:14:00', '2026-02-12 20:52:00', 38, 3, 2, NULL, 1, 1),
(9,  9, '2026-02-12 21:06:00', '2026-02-12 21:44:00', 38, 2, 2, NULL, 1, 1),

-- 2026-02-13
(10, 10, '2026-02-13 17:08:00', '2026-02-13 18:08:00', 60, 3, 3, NULL, 1, 1),

-- 2026-02-15
(11, 11, '2026-02-15 12:10:00', '2026-02-15 13:19:00', 69, 4, 3, NULL, 1, 1),

-- 2026-02-16
(12, 12, '2026-02-16 19:26:00', '2026-02-16 20:30:00', 64, 4, 3, NULL, 1, 1),
(13, 13, '2026-02-16 20:46:00', '2026-02-16 21:32:00', 46, 3, 3, NULL, 1, 1),
(14, 14, '2026-02-16 21:45:00', '2026-02-16 22:32:00', 47, 5, 2, NULL, 1, 1),

-- 2026-02-19
(15, 15, '2026-02-19 19:33:00', '2026-02-19 20:27:00', 54, 4, 3, NULL, 1, 1),
(16, 16, '2026-02-19 20:44:00', '2026-02-19 21:30:00', 46, 4, 3, NULL, 1, 1),

-- =========================
-- PLANNED
-- =========================

-- 2026-02-20
(17, 17, '2026-02-20 17:05:00', '2026-02-20 18:10:00', 65, 4, 3, NULL, 1, 2),
(18, 18, '2026-02-20 18:18:00', '2026-02-20 19:03:00', 45, 4, 3, NULL, 1, 2),

-- 2026-02-21
(19, 19, '2026-02-21 13:06:00', '2026-02-21 13:56:00', 50, 4, 3, NULL, 1, 2),
(20, 20, '2026-02-21 16:04:00', '2026-02-21 16:44:00', 40, 3, 3, NULL, 1, 2),

-- 2026-02-22
(21, 21, '2026-02-22 12:12:00', '2026-02-22 13:04:00', 52, 4, 3, NULL, 1, 2),
(22, 22, '2026-02-22 13:16:00', '2026-02-22 13:58:00', 42, 4, 3, NULL, 1, 2),

-- 2026-02-23
(23, 23, '2026-02-23 19:11:00', '2026-02-23 20:06:00', 55, 5, 3, NULL, 1, 2),
(24, 24, '2026-02-23 20:20:00', '2026-02-23 21:11:00', 51, 5, 3, NULL, 1, 2);

-- Certifications
DELETE FROM Certification;

INSERT INTO Certification
(certification_id, code, name, provider_id, category_id, cert_tier_id, official_url)
VALUES
(1, 'PL-400', 'Microsoft Certified: Power Platform Developer Associate', 1, 5, 2, NULL),
(2, 'AZ-204', 'Microsoft Certified: Azure Developer Associate',          1, 3, 2, NULL),
(3, 'DVA-C02', 'AWS Certified Developer – Associate',                    3, 3, 2, NULL),
(4, 'AI-102',  'Microsoft Certified: Azure AI Engineer Associate',       1, 4, 2, NULL);

-- =========================
-- LIFE LAYER
-- =========================

-- Community
DELETE FROM Community;

INSERT INTO Community (community_id, name, description, website_url, visibility_id) VALUES
(1, 'Codemotion España', 'Organiza meetups y encuentros para la comunidad tech en España.', 'https://community.codemotion.com/codemotion-espana', 1),
(2, 'EmpleaTech', 'Foro de empleo tecnológico en Madrid con stands y agenda de charlas.', 'https://empleatech.es/', 1),
(3, 'AzureBrains', 'Comunidad técnica Azure y AI en Madrid.', 'https://www.meetup.com/azurebrains/', 1),
(4, 'Arcasiles Group', 'Diseñan y producen experiencias que conectan tecnología, cultura y comunidad con creatividad y actitud.', 'https://luma.com/soyngnfn?tk=dHq7fr', 1),
(5, 'Meetup de InnoIT Consulting en Madrid', 'Grupo de meetups técnicos de InnoIT Consulting en Madrid centrados en IA, cloud y desarrollo.', 'https://www.meetup.com/es-ES/meetup-de-innoit-consulting-en-madrid/', 1);

-- City + Venue
DELETE FROM City;

INSERT INTO City (city_id, name, region, country) VALUES
(1, 'Madrid', NULL, 'Spain');

DELETE FROM Venue;

INSERT INTO Venue (venue_id, name, address, city_id, notes) VALUES
(1, 'ILAB', 'C. de Bailén, 41, Centro, 28005 Madrid, Spain', 1, NULL),
(2, 'La Nave', 'C. Cifuentes, 5, Villaverde, 28021 Madrid', 1, NULL),
(3, 'NTT Data Spain – Novus Building', 'Cam. de la Fuente de la Mora, 1, Hortaleza, 28050 Madrid, Spain', 1, NULL),
(4, 'Celonis SL', 'Pl. de Manuel Gómez-Moreno, 2, Tetuán, 28020 Madrid, Spain', 1, NULL),
(5, 'Meet&Go', 'C. de Martín de Vargas, 23, Arganzuela, 28005 Madrid, Spain', 1, NULL);

-- Event
DELETE FROM Event;

INSERT INTO Event (event_id, name, community_id, venue_id, starts_at, ends_at, language, external_url, visibility_id) VALUES
(
  1,
  'CodeMeet after Tech– Donde la comunidad se encuentra',
  1,
  1,
  '2026-02-18 18:15:00',
  '2026-02-18 20:30:00',
  'Spanish',
  'https://community.codemotion.com/codemotion-espana/meetups/codemeet-after-tech-donde-la-comunidad-se-encuentra',
  1
),
(
  2,
  'EmpleaTech 2026 (Edición Madrid)',
  2,
  2,
  '2026-02-04 09:20:00',
  '2026-02-04 14:00:00',
  'Spanish',
  'https://empleatech.es/agenda/',
  1
),
(
  3,
  'Season of AI – MCP by AzureBrains',
  3,
  3,
  '2026-01-29 18:30:00',
  '2026-01-29 19:30:00',
  'Spanish',
  'https://www.meetup.com/azurebrains/events/312537177/',
  1
),
(
  4,
  'Fintech CONF 2026',
  4,
  4,
  '2026-01-28 18:45:00',
  '2026-01-28 21:30:00',
  'Spanish',
  'https://luma.com/soyngnfn?tk=dHq7fr',
  1
),
(
  5,
  'Con licencia para razonar: IA al estilo 007',
  5,
  5,
  '2026-01-21 18:30:00',
  '2026-01-21 20:30:00',
  'Spanish',
  'https://www.meetup.com/es-ES/meetup-de-innoit-consulting-en-madrid/events/312499540/',
  1
);

-- Role catalog
DELETE FROM Role;

INSERT INTO Role (role_id, name, notes) VALUES
(1, 'attendee',  'Attended the event'),
(2, 'speaker',   'Spoke at the event'),
(3, 'community-collaborator', 'Supported event promotion and community engagement');

-- Your participation
DELETE FROM EventParticipation;

INSERT INTO EventParticipation (participation_id, person_name, event_id, role_id, notes, visibility_id) VALUES
(1, 'Rukaya Masmoudi Messaoud', 1, 1, 'Attended as participant.', 1),
(2, 'Rukaya Masmoudi Messaoud', 2, 2, 'Speaker with Patricia Rodríguez Vaquero.', 1),
(3, 'Rukaya Masmoudi Messaoud', 3, 3, 'Supported promotion and community engagement for the meetup.', 1),
(4, 'Rukaya Masmoudi Messaoud', 4, 1, 'Attended as participant.', 1),
(5, 'Rukaya Masmoudi Messaoud', 5, 1, 'Attended as participant.', 1);

-- Your contribution
DELETE FROM Contribution;

INSERT INTO Contribution (contribution_id, event_id, type, title, description, starts_at, ends_at, visibility_id) VALUES
(
  1,
  2,
  'talk',
  'Ser visible para poder existir: Out in Tech, identidad, resiliencia y crecimiento profesional',
  'Tech Career Stories Room (Sala 7) — Charla 5. Shared with Patricia Rodríguez Vaquero.',
  '2026-02-04 11:40:00',
  '2026-02-04 11:55:00',
  1
);

-- Media assets
DELETE FROM MediaAsset;

INSERT INTO MediaAsset (asset_id, asset_type, taken_at, storage_ref, caption, visibility_id) VALUES
(
  1,
  'PHOTO',
  '2026-02-18 19:30:00',
  'docs/assets/events/codemeet-after-tech-cover.jpg',
  'Panel en CodeMeet after Tech (Codemotion España).',
  1
),
(
  2,
  'PHOTO',
  '2026-02-04 11:50:00',
  'docs/assets/events/empleatech-2026-cover.jpg',
  'Charla en EmpleaTech 2026 en La Nave (Madrid).',
  1
),
(
  3,
  'PHOTO',
  '2026-01-29 19:00:00',
  'docs/assets/events/azurebrains-season-ai-mcp-cover.jpg',
  'Presentación Season of AI – MCP by AzureBrains.',
  1
),
(
  4,
  'PHOTO',
  '2026-01-28 19:00:00',
  'docs/assets/events/fintech-conf-2026-cover.jpg',
  'Asistencia a Fintech CONF 2026 en las oficinas de Celonis (Madrid).',
  1
),
(
  5,
  'PHOTO',
  '2026-01-21 19:30:00',
  'docs/assets/events/con-licencia-ia-007-cover.jpg',
  'Meetup "Con licencia para razonar: IA al estilo 007" de InnoIT Consulting en Meet&Go (Madrid).',
  1
);

-- Event media
DELETE FROM EventMedia;

INSERT INTO EventMedia (event_id, asset_id, is_cover) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1);

-- Posts
DELETE FROM Post;

INSERT INTO Post (
  post_id,
  platform,
  url,
  published_at,
  title,
  notes,
  visibility_id
) VALUES
(
  1,
  'LinkedIn',
  'https://www.linkedin.com/posts/rukaya-masmoudi_alcachofas-activity-7422911684425674752-jhbi?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEAMnmQByJUnEXTUyWJqTyUlfPm1itelPDI',
  '2026-01-30 10:00:00',
  'Post en LinkedIn sobre Fintech CONF 2026 (Arcasiles)',
  'Publicación en LinkedIn comentando la experiencia en Fintech CONF 2026 organizado por Arcasiles en las oficinas de Celonis (Madrid).',
  1
),
(
  2,
  'LinkedIn',
  'https://www.linkedin.com/posts/rukaya-masmoudi_el-mi%C3%A9rcoles-estuve-en-el-meetup-con-licencia-activity-7421114622314704897-SYqr?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEAMnmQByJUnEXTUyWJqTyUlfPm1itelPDI',
  '2026-01-23 10:00:00',
  'Post en LinkedIn sobre el meetup "Con licencia para razonar: IA al estilo 007"',
  'Publicación en LinkedIn resumiendo la charla de Celeste Tania Sánchez Fresneda sobre agentes de IA al estilo James Bond en el meetup de InnoIT Consulting.',
  1
);

-- Link Event ↔ Post
DELETE FROM EventPost;

INSERT INTO EventPost (event_id, post_id) VALUES
(4, 1),
(5, 2);