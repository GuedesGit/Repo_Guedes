namespace FlappyBirdForms
{
    using System;
    using System.Drawing;
    using System.Windows.Forms;

    
    public partial class FlappyBirdGame : Form
    {
        private Rectangle bird;
        private Rectangle[] pipes = new Rectangle[4];
        private Timer gameTimer;
        private float verticalSpeed = 0;
        private const float gravity = 0.5f;
        private const float jumpSpeed = -8f;
        private int score = 0;
        private bool isGameOver = false;

        // Images
        private Image birdImage;
        private Image backgroundImage;

        // Background scrolling
        private int backgroundX1 = 0;
        private int backgroundX2;
        private const int scrollSpeed = 2;

        private bool[] pipesPassed; // Track which pipes have been passed

        public FlappyBirdGame()
        {
            this.Width = 800;
            this.Height = 600;
            this.DoubleBuffered = true;
            this.BackColor = Color.LightBlue;
            this.Text = "Flappy Bird";

            // Initialize pipes passed array
            pipesPassed = new bool[pipes.Length / 2];

            // Load images
            try
            {
                birdImage = Image.FromFile("Resources/bird.png");
                backgroundImage = Image.FromFile("Resources/background.png");

                // Set second background position
                backgroundX2 = backgroundImage.Width;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Could not load images. Make sure they exist in the Resources folder.\nError: {ex.Message}");
                birdImage = null;
                backgroundImage = null;
            }

            bird = new Rectangle(100, Height / 2, 40, 40);

            InitializePipes();

            gameTimer = new Timer();
            gameTimer.Interval = 20;
            gameTimer.Tick += GameLoop;
            gameTimer.Start();

            this.KeyDown += new KeyEventHandler(OnKeyDown);
        }

        private void InitializePipes()
        {
            Random rand = new Random();
            int pipeGap = 200;
            int minHeight = 50;

            for (int i = 0; i < pipes.Length; i += 2)
            {
                int x = 800 + (i / 2) * 400;
                int height = rand.Next(minHeight, Height - pipeGap - minHeight);

                // Make pipes wider for better appearance
                pipes[i] = new Rectangle(x, 0, 80, height);
                pipes[i + 1] = new Rectangle(x, height + pipeGap, 80, Height - (height + pipeGap));
            }

            // Reset pipes passed array
            pipesPassed = new bool[pipes.Length / 2];
        }

        private void UpdateBackground()
        {
            // Move backgrounds to the left
            backgroundX1 -= scrollSpeed;
            backgroundX2 -= scrollSpeed;

            // If a background has moved completely off screen, reset it to the right
            if (backgroundX1 + backgroundImage.Width <= 0)
                backgroundX1 = backgroundX2 + backgroundImage.Width;
            if (backgroundX2 + backgroundImage.Width <= 0)
                backgroundX2 = backgroundX1 + backgroundImage.Width;
        }

        private void GameLoop(object sender, EventArgs e)
        {
            if (isGameOver)
                return;

            // Update background position
            UpdateBackground();

            verticalSpeed += gravity;
            bird.Y += (int)verticalSpeed;

            // Update pipes and check for scoring
            for (int i = 0; i < pipes.Length; i += 2)
            {
                // Move pipes
                pipes[i].X -= 3;
                pipes[i + 1].X -= 3;

                // Check if bird has passed this pipe pair
                int pipeIndex = i / 2;
                if (!pipesPassed[pipeIndex] && bird.X > pipes[i].Right)
                {
                    pipesPassed[pipeIndex] = true;
                    score++;
                    // Optional: Add sound effect or visual feedback here
                }

                // Reset pipes when they move off screen
                if (pipes[i].Right < 0)
                {
                    Random rand = new Random();
                    int pipeGap = 200;
                    int minHeight = 50;
                    int height = rand.Next(minHeight, Height - pipeGap - minHeight);

                    pipes[i].X = 800;
                    pipes[i].Height = height;
                    pipes[i + 1].X = 800;
                    pipes[i + 1].Y = height + pipeGap;
                    pipes[i + 1].Height = Height - (height + pipeGap);

                    // Reset passed flag for this pipe pair
                    pipesPassed[pipeIndex] = false;
                }
            }

            if (bird.Y < 0 || bird.Y + bird.Height > Height)
            {
                GameOver();
            }

            foreach (var pipe in pipes)
            {
                if (bird.IntersectsWith(pipe))
                {
                    GameOver();
                }
            }

            this.Invalidate();
        }

        private void OnKeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Space)
            {
                if (isGameOver)
                {
                    isGameOver = false;
                    score = 0;
                    bird.Y = Height / 2;
                    verticalSpeed = 0;
                    InitializePipes();

                    // Reset background positions
                    backgroundX1 = 0;
                    backgroundX2 = backgroundImage?.Width ?? 0;

                    gameTimer.Start();
                }
                else
                {
                    verticalSpeed = jumpSpeed;
                }
            }
        }

        private void GameOver()
        {
            isGameOver = true;
            gameTimer.Stop();
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            base.OnPaint(e);
            Graphics g = e.Graphics;

            // Draw scrolling background
            if (backgroundImage != null)
            {
                g.DrawImage(backgroundImage, backgroundX1, 0, this.Width, this.Height);
                g.DrawImage(backgroundImage, backgroundX2, 0, this.Width, this.Height);
            }

            // Draw improved retro pipes
            foreach (var pipe in pipes)
            {
                // Main pipe body
                g.FillRectangle(Brushes.Green, pipe);

                // Lighter edge (left side)
                using (var lightBrush = new SolidBrush(Color.FromArgb(144, 238, 144))) // Light green
                {
                    g.FillRectangle(lightBrush, pipe.X, pipe.Y, 5, pipe.Height);
                }

                // Darker edge (right side)
                using (var darkBrush = new SolidBrush(Color.FromArgb(0, 100, 0))) // Dark green
                {
                    g.FillRectangle(darkBrush, pipe.Right - 5, pipe.Y, 5, pipe.Height);
                }

                // Pipe cap
                int capHeight = 30;
                int capExtension = 10;
                Rectangle cap;

                if (Array.IndexOf(pipes, pipe) % 2 == 0) // Top pipe
                {
                    cap = new Rectangle(
                        pipe.X - capExtension,
                        pipe.Bottom - capHeight,
                        pipe.Width + (capExtension * 2),
                        capHeight
                    );
                }
                else // Bottom pipe
                {
                    cap = new Rectangle(
                        pipe.X - capExtension,
                        pipe.Y,
                        pipe.Width + (capExtension * 2),
                        capHeight
                    );
                }

                // Draw pipe cap
                g.FillRectangle(Brushes.Green, cap);

                // Cap highlights
                g.FillRectangle(new SolidBrush(Color.FromArgb(144, 238, 144)),
                    cap.X, cap.Y, 5, cap.Height); // Left highlight
                g.FillRectangle(new SolidBrush(Color.FromArgb(0, 100, 0)),
                    cap.Right - 5, cap.Y, 5, cap.Height); // Right shadow

                // Cap top/bottom edge
                if (Array.IndexOf(pipes, pipe) % 2 == 0) // Top pipe
                {
                    g.FillRectangle(new SolidBrush(Color.FromArgb(0, 100, 0)),
                        cap.X, cap.Bottom - 5, cap.Width, 5); // Bottom shadow
                }
                else // Bottom pipe
                {
                    g.FillRectangle(new SolidBrush(Color.FromArgb(144, 238, 144)),
                        cap.X, cap.Y, cap.Width, 5); // Top highlight
                }
            }

            // Draw bird
            if (birdImage != null)
            {
                g.DrawImage(birdImage, bird);
            }
            else
            {
                g.FillEllipse(Brushes.Yellow, bird);
            }

            // Draw score
            using (var scoreBrush = new SolidBrush(Color.White))
            using (var scoreFont = new Font("Arial", 20, FontStyle.Bold))
            {
                g.DrawString($"Score: {score}", scoreFont, scoreBrush, new Point(10, 10));
            }

            if (isGameOver)
            {
                string gameOver = "Game Over! Press Space to Restart";
                using (var gameOverFont = new Font("Arial", 20, FontStyle.Bold))
                {
                    SizeF size = g.MeasureString(gameOver, gameOverFont);
                    using (var shadowBrush = new SolidBrush(Color.Black))
                    {
                        g.DrawString(gameOver, gameOverFont, shadowBrush,
                            (Width - size.Width) / 2 + 2,
                            (Height - size.Height) / 2 + 2);
                    }
                    using (var textBrush = new SolidBrush(Color.White))
                    {
                        g.DrawString(gameOver, gameOverFont, textBrush,
                            (Width - size.Width) / 2,
                            (Height - size.Height) / 2);
                    }
                }
            }
        }

        protected override void OnFormClosing(FormClosingEventArgs e)
        {
            base.OnFormClosing(e);
            // Clean up resources
            birdImage?.Dispose();
            backgroundImage?.Dispose();
        }


    }
}
