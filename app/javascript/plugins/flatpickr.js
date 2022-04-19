import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";


const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    // plugins: [new rangePlugin({ input: "#range_end" })]
  });
}


const initFlatpickr2 = () => {
  flatpickr(".datepicker", {
  altInput: true,
  });
}


export { initFlatpickr };
export { initFlatpickr2 };
