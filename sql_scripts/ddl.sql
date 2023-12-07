DROP TABLE IF EXISTS credit_card;
CREATE TABLE IF NOT EXISTS credit_card (
    credit_card_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    credit_card_number VARCHAR(16) NOT NULL,
    UNIQUE (customer_id, credit_card_number),
    CONSTRAINT customer_cc_fk FOREIGN KEY (customer_id)
        REFERENCES auth_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
    expiration_month INT NOT NULL CHECK (expiration_month >= 0 AND expiration_month <= 12),
    expiration_year INT NOT NULL,
    security_code VARCHAR(4) NOT NULL
);


DROP TABLE IF EXISTS address;
CREATE TABLE IF NOT EXISTS address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    CONSTRAINT customer_address_fk FOREIGN KEY (customer_id)
        REFERENCES auth_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
    street_no VARCHAR(10) NOT NULL,
    street_name VARCHAR(255) NOT NULL,
    state_abbreviation ENUM('AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY') NOT NULL,
    zip_code VARCHAR(5) NOT NULL,
    CONSTRAINT address_ak UNIQUE (customer_id, street_no, street_name, state_abbreviation, zip_code)
);


DROP TABLE IF EXISTS publisher;
CREATE TABLE IF NOT EXISTS publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(255) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS game_mechanic;
CREATE TABLE IF NOT EXISTS game_mechanic (
    mechanic_id INT PRIMARY KEY AUTO_INCREMENT,
    mechanic_name VARCHAR(50) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS designer;
CREATE TABLE IF NOT EXISTS designer (
    designer_id INT PRIMARY KEY AUTO_INCREMENT,
    designer_name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS game_type;
CREATE TABLE IF NOT EXISTS game_type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS gameitem;
CREATE TABLE IF NOT EXISTS gameitem (
    game_id INT PRIMARY KEY AUTO_INCREMENT,
    game_name VARCHAR(255) UNIQUE NOT NULL,
    published_year INT NOT NULL,
    min_player INT NOT NULL,
    max_player INT NOT NULL,
    min_age INT NOT NULL,
    min_time INT NOT NULL,
    max_time INT NOT NULL,
    is_cooperative BOOLEAN NOT NULL DEFAULT FALSE,
    num_review INT NOT NULL DEFAULT 0,
    avg_rating FLOAT NOT NULL DEFAULT 0,
    std_dev_rating FLOAT NOT NULL DEFAULT 0,
    rated_complexity FLOAT NOT NULL DEFAULT 0,
    rated_language_dependency FLOAT NOT NULL DEFAULT 0,
    CONSTRAINT rating_range CHECK (avg_rating >= 0 AND avg_rating <= 10),
    CONSTRAINT std_dev_rating CHECK (std_dev_rating >= 0 AND std_dev_rating <= 10),
    CONSTRAINT complex_range CHECK (rated_complexity >= 0 AND rated_complexity <= 10),
    CONSTRAINT language_dependency_rating CHECK (rated_language_dependency >= 0 AND rated_language_dependency <= 10),
    designer_id INT,
    publisher_id INT,
    mechanic_id INT,
    type_id INT,
	price INT,
    CONSTRAINT fk_designer FOREIGN KEY (designer_id) REFERENCES designer(designer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_publisher FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_mechanic FOREIGN KEY (mechanic_id) REFERENCES game_mechanic(mechanic_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_type FOREIGN KEY (type_id) REFERENCES game_type(type_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS store_order;
CREATE TABLE IF NOT EXISTS store_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_status ENUM("In Progress", "Placed", "Fulfilled") NOT NULL,
    date_ordered DATE NOT NULL,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    credit_card_id INT NOT NULL,
    CONSTRAINT customer_order_fk FOREIGN KEY (customer_id) REFERENCES auth_user(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT address_fk FOREIGN KEY (address_id) REFERENCES address(address_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT credit_card_fk FOREIGN KEY (credit_card_id) REFERENCES credit_card(credit_card_id) ON UPDATE RESTRICT ON DELETE RESTRICT
);

DROP TABLE IF EXISTS order_item;
CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    game_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    UNIQUE (order_id, game_id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES store_order(order_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_game FOREIGN KEY (game_id) REFERENCES gameitem(game_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

DROP TABLE IF EXISTS review;
CREATE TABLE IF NOT EXISTS review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    game_id INT NOT NULL,
    rating INT NOT NULL,
    text_review TEXT,
    complexity_rating INT NOT NULL,
    language_dependency_rating INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES auth_user(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (game_id) REFERENCES gameitem(game_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT review_review_range CHECK (rating >= 0 AND rating <= 10),
    CONSTRAINT review_complex_range CHECK (complexity_rating >= 0 AND complexity_rating <= 10),
    CONSTRAINT review_language_dependency_rating CHECK (language_dependency_rating >= 0 AND language_dependency_rating <= 10)
);


DELIMITER //
DROP PROCEDURE IF EXISTS insert_review_and_update_score //
CREATE PROCEDURE insert_review_and_update_score(
    IN p_customer_id INT,
    IN p_game_id INT,
    IN p_rating INT,
    IN p_text_review TEXT,
    IN p_complexity_rating INT,
    IN p_language_dependency_rating INT
)
BEGIN
    DECLARE avg_rating_new FLOAT;
    DECLARE std_dev_rating_new FLOAT;
    -- Insert new review
    INSERT INTO review (
        customer_id, game_id, rating, text_review, complexity_rating, language_dependency_rating
    ) VALUES (
        p_customer_id, p_game_id, p_rating, p_text_review, p_complexity_rating, p_language_dependency_rating
    );
    
    UPDATE gameitem
    SET
        avg_rating = (avg_rating * num_review + p_rating) / (num_review + 1),
        std_dev_rating = POWER((std_dev_rating * std_dev_rating * num_review + (p_rating - avg_rating) * (p_rating - avg_rating_new)) / (num_review + 1), 0.5),
        rated_complexity = (rated_complexity * (num_review) + p_complexity_rating) / (num_review + 1),
        rated_language_dependency = (rated_language_dependency * (num_review) + p_language_dependency_rating) / (num_review + 1),
        num_review = num_review + 1
    WHERE game_id = p_game_id;
END //

DROP TRIGGER IF EXISTS after_review_update //
CREATE TRIGGER after_review_update
AFTER UPDATE ON review
FOR EACH ROW
BEGIN
    DECLARE avg_rating_new FLOAT;
    DECLARE std_dev_rating_new FLOAT;
    -- Update gameitem scores for updated review
    UPDATE gameitem 
    SET 
        avg_rating = (avg_rating * num_review - OLD.rating + NEW.rating) / num_review,
        rated_complexity = (rated_complexity * num_review - OLD.complexity_rating + NEW.complexity_rating) / num_review,
        rated_language_dependency = (rated_language_dependency * num_review - OLD.language_dependency_rating + NEW.language_dependency_rating) / num_review
    WHERE
        game_id = NEW.game_id;
    
    SELECT 
        avg_rating
    INTO avg_rating_new
    FROM
        gameitem
    WHERE
        game_id = NEW.game_id;
    
    SELECT 
        POW(SUM(POWER(rating - avg_rating_new, 2))/ COUNT(*), 0.5) 
    INTO std_dev_rating_new
    FROM
        review
    WHERE
        game_id = NEW.game_id
    GROUP BY game_id;
    
    UPDATE gameitem
    SET std_dev_rating = std_dev_rating_new
    WHERE game_id = NEW.game_id;
    
END //


DROP TRIGGER IF EXISTS after_review_delete //
CREATE TRIGGER after_review_delete
AFTER DELETE ON review
FOR EACH ROW
BEGIN
    DECLARE avg_rating_new FLOAT;
    DECLARE std_dev_rating_new FLOAT;
    -- Update gameitem scores for deleted review
    UPDATE gameitem
    SET
        avg_rating = CASE WHEN num_review > 1 THEN (avg_rating * num_review - OLD.rating) / (num_review - 1) ELSE 0 END,
        rated_complexity = CASE WHEN num_review > 1 THEN (rated_complexity * num_review - OLD.complexity_rating) / (num_review - 1) ELSE 0 END,
        rated_language_dependency = CASE WHEN num_review > 1 THEN (rated_language_dependency * num_review - OLD.language_dependency_rating) / (num_review - 1) ELSE 0 END,
        num_review = GREATEST(num_review - 1, 0)
    WHERE game_id = OLD.game_id;
    
    SELECT 
        avg_rating
    INTO avg_rating_new FROM
        gameitem
    WHERE
        game_id = OLD.game_id;
    
    SELECT 
        POW(SUM(POWER(rating - avg_rating_new, 2)) / COUNT(*),
            0.5)
    INTO std_dev_rating_new FROM
        review
    WHERE
        game_id = OLD.game_id
    GROUP BY game_id;
    
    UPDATE gameitem 
    SET 
        std_dev_rating = IFNULL(std_dev_rating_new, 0)
    WHERE
        game_id = OLD.game_id;
    
END //


DROP FUNCTION IF EXISTS calculate_total_revenue //
CREATE FUNCTION calculate_total_revenue() RETURNS FLOAT
READS SQL DATA
BEGIN
    DECLARE total_revenue FLOAT;
    
    SELECT SUM(o.quantity * g.price)
    INTO total_revenue
    FROM store_order s
    JOIN order_item o ON s.order_id = o.order_item_id
    JOIN gameitem g ON o.game_id = g.game_id;
    
    RETURN total_revenue;
END //


DROP PROCEDURE IF EXISTS calculate_game_revenue //
CREATE PROCEDURE calculate_game_revenue()
BEGIN
    SELECT 
        g.game_name,
        COALESCE(SUM(quantity * g.price), 0) AS total_revenue
    FROM
        gameitem g
        LEFT JOIN
        order_item o ON g.game_id = o.game_id
        LEFT JOIN
        store_order s ON o.order_id = s.order_id
    GROUP BY g.game_name;
END //


DROP PROCEDURE IF EXISTS get_most_grossing_designer //
CREATE PROCEDURE get_most_grossing_designer()
BEGIN
    SELECT 
        designer_name, SUM(o.quantity * g.price) AS sum_designer
    FROM
        order_item o
        JOIN
        gameitem g ON o.game_id = g.game_id
        JOIN
        designer d ON g.designer_id = d.designer_id
    GROUP BY d.designer_name
    ORDER BY sum_designer DESC
    LIMIT 1;
END //


DROP PROCEDURE IF EXISTS get_most_grossing_publisher //
CREATE PROCEDURE get_most_grossing_publisher()
BEGIN
    SELECT 
        publisher_name, SUM(o.quantity * g.price) AS sum_publisher
    FROM
        order_item o
        JOIN
        gameitem g ON o.game_id = g.game_id
        JOIN
        publisher p ON g.publisher_id = p.publisher_id
    GROUP BY p.publisher_name
    ORDER BY sum_publisher DESC
    LIMIT 1;
END //


DROP PROCEDURE IF EXISTS get_most_grossing_game_type //
CREATE PROCEDURE get_most_grossing_game_type()
BEGIN
    SELECT 
        type_name, SUM(o.quantity * g.price) AS sum_type
    FROM
        order_item o
        JOIN
        gameitem g ON o.game_id = g.game_id
        JOIN
        game_type gt ON g.type_id = gt.type_id
    GROUP BY gt.type_name
    ORDER BY sum_type DESC
    LIMIT 1;
END //


DROP PROCEDURE IF EXISTS get_most_grossing_game_mechanic //
CREATE PROCEDURE get_most_grossing_game_mechanic()
BEGIN
    SELECT 
        mechanic_name, SUM(o.quantity * g.price) AS sum_mechanic
    FROM
        order_item o
        JOIN
        gameitem g ON o.game_id = g.game_id
        JOIN
        game_mechanic gm ON g.mechanic_id = gm.mechanic_id
    GROUP BY gm.mechanic_name
    ORDER BY sum_mechanic DESC
    LIMIT 1;
END //
