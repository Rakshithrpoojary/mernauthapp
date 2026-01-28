import { fetchBaseQuery, createApi } from "@reduxjs/toolkit/query/react";

// const baseQuery = fetchBaseQuery({ baseUrl: '' });

export const apiSlice = createApi({
  reducerPath: "api",
  baseQuery: fetchBaseQuery({
    baseUrl: "http://a6d35c9945ce542ad962db7d36ba636d-1979400558.ap-south-1.elb.amazonaws.com:80",
    credentials: "include",
  }),
  tagTypes: ["User"],
  endpoints: (builder) => ({}),
});
