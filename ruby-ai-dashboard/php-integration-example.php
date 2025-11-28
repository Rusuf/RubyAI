<?php
/**
 * Ruby AI Dashboard - PHP Integration Example
 * 
 * This file shows how to integrate the Ruby AI Dashboard into your existing PHP application.
 * Simply add the button and include the dashboard HTML.
 */
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ruby Restaurant - Main Dashboard</title>
    <style>
        /* Your existing PHP styles */
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background: #f5f5f5;
        }

        .main-header {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Ruby AI Button Styles */
        .ruby-ai-btn {
            background: linear-gradient(135deg, #ff6b6b, #feca57);
            color: white;
            border: none;
            padding: 14px 28px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 12px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .ruby-ai-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
        }

        .ruby-ai-btn:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>
    <!-- Your existing PHP header -->
    <div class="main-header">
        <h1>Ruby Restaurant Dashboard</h1>
        <p>Welcome back, <?php echo $_SESSION['user_name'] ?? 'Admin'; ?>!</p>
        
        <!-- THE MAGIC BUTTON -->
        <button class="ruby-ai-btn" onclick="openAIDashboard()">
            <span>🤖</span>
            <span>My Ruby AI</span>
        </button>
    </div>

    <!-- Your existing PHP content -->
    <div class="content">
        <h2>Sales Overview</h2>
        <p>Your regular PHP dashboard content goes here...</p>
    </div>

    <!-- STEP 1: Include the AI Dashboard HTML -->
    <?php include 'ruby-ai-dashboard.html'; ?>

    <!-- STEP 2: That's it! The button will now open the glassmorphic AI modal -->
    
    <!-- Optional: You can also trigger it programmatically -->
    <script>
        // Example: Auto-open on first visit
        // if (!localStorage.getItem('aiDashboardSeen')) {
        //     setTimeout(() => {
        //         openAIDashboard();
        //         localStorage.setItem('aiDashboardSeen', 'true');
        //     }, 2000);
        // }
    </script>
</body>
</html>
