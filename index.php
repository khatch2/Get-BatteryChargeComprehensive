<?php
 setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // Create table messages
 $file_db->exec("CREATE TABLE IF NOT EXISTS messages ( id INTEGER PRIMARY KEY, title TEXT, message TEXT, time TEXT)"); // Prepare INSERT statement to SQLite3 file db
 $insert = "INSERT INTO messages (title, message, time) VALUES (:title, :message, :time)";
 $stmt = $file_db->prepare($insert); // Bind parameters to statement variables
 $stmt->bindParam(':title', $title);
 $stmt->bindParam(':message', $message); $stmt->bindParam(':time', $time); // Insert a row
 $title = 'Hello'; $message = 'Just testing'; $time = date('Y-m-d H:i:s'); $stmt->execute(); // Select all data from memory db messages table
 $result = $file_db->query('SELECT * FROM messages'); // Loop thru all data from messages table and print it
 foreach($result as $m) {
	 echo "Id: " . $m['id'] . "\n"; echo "Title: " . $m['title'] . "\n"; echo "Message: " . $m['message'] . "\n";
	 echo "Time: " . $m['time'] . "\n"; echo "\n";
	 }
	 // Close file db connection
	 $file_db = null;
	 } catch(PDOException $e)
	 { 
	 // Print PDOException message
	 echo $e->getMessage(); 
	 } 
 ?> 
