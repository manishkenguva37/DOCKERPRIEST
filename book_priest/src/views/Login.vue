<template>
  <div class="auth-container">
    <!-- Top Navigation -->
    <nav class="top-nav">
      <div class="nav-left">
        <button class="back-btn" @click="$router.push('/')">
          <span class="material-symbols-outlined">arrow_back</span>
        </button>
        <h1 class="page-title">Welcome Back</h1>
      </div>
    </nav>

    <!-- Login Form -->
    <div class="auth-content">
      <div class="auth-illustration">
        <div class="illustration-circle">
          <span class="material-symbols-outlined illustration-icon">person</span>
        </div>
        <h2 class="auth-subtitle">Sign in to continue</h2>
        <p class="auth-description">
          Access your bookings, manage your profile, and connect with verified priests.
        </p>
      </div>

      <form class="auth-form" @submit.prevent="handleLogin">
        <!-- Email Input -->
        <div class="form-group">
          <label class="form-label">Email Address</label>
          <div class="input-wrapper">
            <span class="material-symbols-outlined input-icon">email</span>
            <input
              v-model="form.email"
              type="email"
              class="form-input"
              placeholder="Enter your email"
              required
            />
          </div>
        </div>

        <!-- Password Input -->
        <div class="form-group">
          <label class="form-label">Password</label>
          <div class="input-wrapper">
            <span class="material-symbols-outlined input-icon">lock</span>
            <input
              v-model="form.password"
              :type="showPassword ? 'text' : 'password'"
              class="form-input"
              placeholder="Enter your password"
              required
            />
            <button
              type="button"
              class="toggle-password"
              @click="showPassword = !showPassword"
            >
              <span class="material-symbols-outlined">
                {{ showPassword ? 'visibility_off' : 'visibility' }}
              </span>
            </button>
          </div>
        </div>

        <!-- Forgot Password -->
        <div class="form-options">
          <label class="remember-me">
            <input v-model="form.rememberMe" type="checkbox" />
            <span>Remember me</span>
          </label>
          <button type="button" class="forgot-password" @click="forgotPassword">
            Forgot Password?
          </button>
        </div>

        <!-- Submit Button -->
        <AUBUTTON
          type="submit"
          variant="primary"
          label="Sign In"
          size="large"
          class="auth-submit"
          :loading="isLoading"
        />

        <!-- Divider -->
        <div class="auth-divider">
          <span>or continue with</span>
        </div>

        <!-- Social Login -->
        <div class="social-login">
          <button type="button" class="social-btn google" @click="socialLogin('google')">
            <img src="https://www.google.com/favicon.ico" alt="Google" />
            <span>Google</span>
          </button>
          <button type="button" class="social-btn phone" @click="socialLogin('phone')">
            <span class="material-symbols-outlined">smartphone</span>
            <span>Phone</span>
          </button>
        </div>
      </form>

      <!-- Sign Up Link -->
      <div class="auth-footer">
        <p>Don't have an account?</p>
        <router-link to="/signup" class="auth-link">Create Account</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      form: {
        email: "",
        password: "",
        rememberMe: false,
      },
      showPassword: false,
      isLoading: false,
    };
  },
  methods: {
    async handleLogin() {
      this.isLoading = true;
      
      // Simulate API call
      setTimeout(() => {
        this.isLoading = false;
        // Navigate to dashboard on success
        this.$router.push("/dashboard");
      }, 1500);
    },
    forgotPassword() {
      // Handle forgot password
      alert("Forgot password functionality coming soon!");
    },
    socialLogin(provider) {
      // Handle social login
      console.log(`Login with ${provider}`);
    },
  },
};
</script>

<style scoped>
.auth-container {
  min-height: 100vh;
  background-color: #f8f7f5;
  padding-bottom: 24px;
}

/* Top Navigation */
.top-nav {
  display: flex;
  align-items: center;
  padding: 16px 20px;
  background: white;
  border-bottom: 1px solid #e8e8e8;
}

.nav-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.back-btn {
  background: none;
  border: none;
  padding: 8px;
  cursor: pointer;
  color: #2d2a26;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  transition: background 0.2s;
}

.back-btn:hover {
  background: #f5f5f5;
}

.page-title {
  font-size: 20px;
  font-weight: 600;
  color: #2d2a26;
  margin: 0;
}

/* Auth Content */
.auth-content {
  padding: 32px 20px;
  max-width: 400px;
  margin: 0 auto;
}

/* Illustration */
.auth-illustration {
  text-align: center;
  margin-bottom: 32px;
}

.illustration-circle {
  width: 100px;
  height: 100px;
  background: linear-gradient(135deg, #f5993d 0%, #e8842e 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 20px;
}

.illustration-icon {
  font-size: 48px;
  color: white;
}

.auth-subtitle {
  font-size: 22px;
  font-weight: 600;
  color: #2d2a26;
  margin: 0 0 8px;
}

.auth-description {
  font-size: 14px;
  color: #6b6b6b;
  margin: 0;
  line-height: 1.5;
}

/* Form */
.auth-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-label {
  font-size: 14px;
  font-weight: 500;
  color: #2d2a26;
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.input-icon {
  position: absolute;
  left: 14px;
  color: #9a9a9a;
  font-size: 20px;
}

.form-input {
  width: 100%;
  padding: 14px 14px 14px 46px;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  font-size: 15px;
  background: white;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.form-input:focus {
  outline: none;
  border-color: #f5993d;
  box-shadow: 0 0 0 3px rgba(245, 153, 61, 0.1);
}

.form-input::placeholder {
  color: #9a9a9a;
}

.toggle-password {
  position: absolute;
  right: 14px;
  background: none;
  border: none;
  padding: 4px;
  cursor: pointer;
  color: #9a9a9a;
  display: flex;
  align-items: center;
  justify-content: center;
}

.toggle-password:hover {
  color: #6b6b6b;
}

/* Form Options */
.form-options {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 13px;
}

.remember-me {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  color: #6b6b6b;
}

.remember-me input[type="checkbox"] {
  width: 18px;
  height: 18px;
  accent-color: #f5993d;
  cursor: pointer;
}

.forgot-password {
  background: none;
  border: none;
  color: #f5993d;
  font-weight: 500;
  cursor: pointer;
  padding: 0;
}

.forgot-password:hover {
  text-decoration: underline;
}

/* Submit Button */
.auth-submit {
  width: 100%;
}

/* Divider */
.auth-divider {
  display: flex;
  align-items: center;
  gap: 16px;
  margin: 8px 0;
}

.auth-divider::before,
.auth-divider::after {
  content: '';
  flex: 1;
  height: 1px;
  background: #e0e0e0;
}

.auth-divider span {
  font-size: 13px;
  color: #9a9a9a;
}

/* Social Login */
.social-login {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.social-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 12px;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  background: white;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  color: #2d2a26;
  transition: background 0.2s, border-color 0.2s;
}

.social-btn:hover {
  background: #f8f7f5;
  border-color: #d0d0d0;
}

.social-btn img {
  width: 20px;
  height: 20px;
}

.social-btn.phone {
  color: #f5993d;
}

/* Footer */
.auth-footer {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin-top: 32px;
  padding-top: 24px;
  border-top: 1px solid #e8e8e8;
}

.auth-footer p {
  font-size: 14px;
  color: #6b6b6b;
  margin: 0;
}

.auth-link {
  font-size: 14px;
  font-weight: 600;
  color: #f5993d;
  text-decoration: none;
}

.auth-link:hover {
  text-decoration: underline;
}
</style>
