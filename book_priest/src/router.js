import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

// Lazy-load each view for better performance
const SpiritualPlatformHome = () => import("./views/SpiritualPlatformHome.vue");
const ExploreAllPujas = () => import("./views/ExploreAllPujas.vue");
const PujaDetails = () => import("./views/PujaDetails.vue");
const SelectPriest = () => import("./views/SelectPriest.vue");
const CheckoutPayment = () => import("./views/CheckoutPayment.vue");
const BookingConfirmed = () => import("./views/BookingConfirmed.vue");
const DevoteeDashboard = () => import("./views/DevoteeDashboard.vue");
const FestivalSpecial = () => import("./views/FestivalSpecial.vue");
const PlatformAdmin = () => import("./views/PlatformAdmin.vue");
const PriestPartnerDashboard = () => import("./views/PriestPartnerDashboard.vue");
const PriestEarnings = () => import("./views/PriestEarnings.vue");
const ComponentsTest = () => import("./views/ComponentsTest.vue");
const Login = () => import("./views/Login.vue");
const Signup = () => import("./views/Signup.vue");

const routes = [
    // ─── Auth ─────────────────────────────────────────────────────────────────
    {
        path: "/login",
        name: "Login",
        component: Login,
        meta: { title: "Sign In | BookPriest" },
    },
    {
        path: "/signup",
        name: "Signup",
        component: Signup,
        meta: { title: "Create Account | BookPriest" },
    },

    // ─── Public / Home ────────────────────────────────────────────────────────
    {
        path: "/",
        name: "Home",
        component: SpiritualPlatformHome,
        meta: { title: "Home | BookPriest" },
    },

    // ─── Puja Discovery ───────────────────────────────────────────────────────
    {
        path: "/pujas",
        name: "ExploreAllPujas",
        component: ExploreAllPujas,
        meta: { title: "Explore Pujas | BookPriest" },
    },
    {
        path: "/pujas/:id",
        name: "PujaDetails",
        component: PujaDetails,
        props: true,
        meta: { title: "Puja Details | BookPriest" },
    },

    // ─── Booking Flow ─────────────────────────────────────────────────────────
    {
        path: "/pujas/:pujaId/select-priest",
        name: "SelectPriest",
        component: SelectPriest,
        props: true,
        meta: { title: "Select Priest | BookPriest" },
    },
    {
        path: "/checkout",
        name: "CheckoutPayment",
        component: CheckoutPayment,
        meta: { title: "Checkout | BookPriest" },
    },
    {
        path: "/booking-confirmed/:bookingId?",
        name: "BookingConfirmed",
        component: BookingConfirmed,
        props: true,
        meta: { title: "Booking Confirmed | BookPriest" },
    },

    // ─── Devotee Dashboard ────────────────────────────────────────────────────
    {
        path: "/dashboard",
        name: "DevoteeDashboard",
        component: DevoteeDashboard,
        meta: { title: "My Dashboard | BookPriest" },
    },

    // ─── Festival & Special Events ────────────────────────────────────────────
    {
        path: "/festival-special",
        name: "FestivalSpecial",
        component: FestivalSpecial,
        meta: { title: "Festival Special | BookPriest" },
    },

    // ─── Priest Partner ───────────────────────────────────────────────────────
    {
        path: "/priest/dashboard",
        name: "PriestPartnerDashboard",
        component: PriestPartnerDashboard,
        meta: { title: "Priest Dashboard | BookPriest" },
    },
    {
        path: "/priest/earnings",
        name: "PriestEarnings",
        component: PriestEarnings,
        meta: { title: "Earnings | BookPriest" },
    },

    // ─── Admin ────────────────────────────────────────────────────────────────
    {
        path: "/admin",
        name: "PlatformAdmin",
        component: PlatformAdmin,
        meta: { title: "Admin | BookPriest" },
    },

    // ─── Dev / Testing ────────────────────────────────────────────────────────
    {
        path: "/components-test",
        name: "ComponentsTest",
        component: ComponentsTest,
        meta: { title: "Components Test" },
    },

    // ─── 404 Fallback ─────────────────────────────────────────────────────────
    {
        path: "*",
        redirect: "/",
    },
];

const router = new VueRouter({
    mode: "history", // use history mode for clean URLs without #
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition) return savedPosition;
        return { x: 0, y: 0 };
    },
    routes,
});

// Update document title on every navigation
router.afterEach((to) => {
    document.title = to.meta?.title || "BookPriest";
});

export default router;
