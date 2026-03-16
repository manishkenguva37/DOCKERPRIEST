<template>
  <div class="auth-container">
    <!-- Top Navigation -->
    <nav class="top-nav">
      <div class="nav-left">
        <button class="back-btn" @click="$router.go(-1)">
          <span class="material-symbols-outlined">arrow_back</span>
        </button>
        <h1 class="page-title">Create Account</h1>
      </div>
    </nav>

    <!-- Signup Form -->
    <div class="auth-content">
      <div class="auth-illustration">
        <div class="illustration-circle">
          <span class="material-symbols-outlined illustration-icon">person_add</span>
        </div>
        <h2 class="auth-subtitle">Join BookPriest</h2>
        <p class="auth-description">
          Create your account to book pujas, connect with priests, and receive divine blessings.
        </p>
      </div>

      <!-- Account Type Selection -->
      <div class="account-type">
        <label class="type-label">I am a:</label>
        <div class="type-options">
          <button
            type="button"
            class="type-btn"
            :class="{ active: form.accountType === 'devotee' }"
            @click="form.accountType = 'devotee'"
          >
            <span class="material-symbols-outlined">person</span>
            <span>Devotee</span>
          </button>
          <button
            type="button"
            class="type-btn"
            :class="{ active: form.accountType === 'priest' }"
            @click="form.accountType = 'priest'"
          >
            <span class="material-symbols-outlined">person_4</span>
            <span>Priest</span>
          </button>
        </div>
      </div>

      <form class="auth-form" @submit.prevent="handleSignup">
        <!-- Full Name -->
        <div class="form-group">
          <label class="form-label">Full Name</label>
          <div class="input-wrapper">
            <span class="material-symbols-outlined input-icon">person</span>
            <input
              v-model="form.fullName"
              type="text"
              class="form-input"
              placeholder="Enter your full name"
              required
            />
          </div>
        </div>

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

        <!-- Phone Input -->
        <div class="form-group">
          <label class="form-label">Phone Number</label>
          <div class="input-wrapper">
            <span class="material-symbols-outlined input-icon">smartphone</span>
            <input
              v-model="form.phone"
              type="tel"
              class="form-input"
              placeholder="Enter your phone number"
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
              placeholder="Create a password (min 8 chars)"
              minlength="8"
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

        <!-- Confirm Password -->
        <div class="form-group">
          <label class="form-label">Confirm Password</label>
          <div class="input-wrapper">
            <span class="material-symbols-outlined input-icon">lock_outline</span>
            <input
              v-model="form.confirmPassword"
              :type="showConfirmPassword ? 'text' : 'password'"
              class="form-input"
              placeholder="Confirm your password"
              required
            />
            <button
              type="button"
              class="toggle-password"
              @click="showConfirmPassword = !showConfirmPassword"
            >
              <span class="material-symbols-outlined">
                {{ showConfirmPassword ? 'visibility_off' : 'visibility' }}
              </span>
            </button>
          </div>
        </div>

        <!-- Terms Checkbox -->
        <div class="form-options">
          <label class="terms-checkbox">
            <input v-model="form.agreeToTerms" type="checkbox" required />
            <span>I agree to the <a href="#" @click.prevent="showTerms">Terms of Service</a> and <a href="#" @click.prevent="showPrivacy">Privacy Policy</a></span>
          </label>
        </div>

        <!-- Submit Button -->
        <AUBUTTON
          type="submit"
          variant="primary"
          label="Create Account"
          size="large"
          class="auth-submit"
          :loading="isLoading"
        />

        <!-- Divider -->
        <div class="auth-divider">
          <span>or sign up with</span>
        </div>

        <!-- Social Signup -->
        <div class="social-login">
          <button type="button" class="social-btn google" @click="socialSignup('google')">
            <img src="https://www.google.com/favicon.ico" alt="Google" />
            <span>Google</span>
          </button>
          <button type="button" class="social-btn phone" @click="socialSignup('phone')">
            <span class="material-symbols-outlined">smartphone</span>
            <span>Phone</span>
          </button>
        </div>
      </form>

      <!-- Login Link -->
      <div class="auth-footer">
        <p>Already have an account?</p>
        <router-link to="/login" class="auth-link">Sign In</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Signup",
  data() {
    return {
      form: {
        accountType: "devotee",
        fullName: "",
        email: "",
        phone: "",
        password: "",
        confirmPassword: "",
        agreeToTerms: false,
      },
      showPassword: false,
      showConfirmPassword: false,
      isLoading: false,
    };
  },
  methods: {
    async handleSignup() {
      // Validate passwords match
      if (this.form.password !== this.form.confirmPassword) {
        alert("Passwords do not match!");
        return;
      }

      this.isLoading = true;
      
      // Simulate API call
      setTimeout(() => {
        this.isLoading = false;
        // Navigate to appropriate dashboard based on account type
        const route = this.form.accountType === 'priest' ? '/priest/dashboard' : '/dashboard';
        this.$router.push(route);
      }, 1500);
    },
    showTerms() {
      alert("Terms of Service coming soon!");
    },
    showPrivacy() {
      alert("Privacy Policy coming soon!");
    },
    socialSignup(provider) {
      // Handle social signup
      console.log(`Signup with ${provider}`);
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
  padding: 24px 20px;
  max-width: 400px;
  margin: 0 auto;
}

/* Illustration */
.auth-illustration {
  text-align: center;
  margin-bottom: 24px;
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

/* Account Type Selection */
.account-type {
  margin-bottom: 20px;
}

.type-label {
  display: block;
  font-size: 14px;
  font-weight: 500;
  color: #2d2a26;
  margin-bottom: 10px;
}

.type-options {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.type-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 14px;
  border: 2px solid #e0e0e0;
  border-radius: 12px;
  background: white;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  color: #6b6b6b;
  transition: all 0.2s;
}

.type-btn:hover {
  border-color: #f5993d;
  color: #f5993d;
}

.type-btn.active {
  border-color: #f5993d;
  background: rgba(245, 153, 61, 0.05);
  color: #f5993d;
}

.type-btn .material-symbols-outlined {
  font-size: 20px;
}

/* Form */
.auth-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
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
  align-items: flex-start;
  font-size: 13px;
}

.terms-checkbox {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  cursor: pointer;
  color: #6b6b6b;
  line-height: 1.5;
}

.terms-checkbox input[type="checkbox"] {
  width: 18px;
  height: 18px;
  accent-color: #f5993d;
  cursor: pointer;
  margin-top: 1px;
  flex-shrink: 0;
}

.terms-checkbox a {
  color: #f5993d;
  text-decoration: none;
  font-weight: 500;
}

.terms-checkbox a:hover {
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
  margin: 4px 0;
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

/* Social Signup */
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
  margin-top: 24px;
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
