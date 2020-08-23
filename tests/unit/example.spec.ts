import { shallowMount } from "@vue/test-utils";
import Nothing from "@/components/Nothing.vue";

describe("Nothing.vue", () => {
  it("renders", () => {
    const wrapper = shallowMount(Nothing);
    expect(wrapper.text()).toMatch("Nothing here for now…");
  });
});
