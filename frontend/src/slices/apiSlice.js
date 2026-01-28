import { fetchBaseQuery, createApi } from "@reduxjs/toolkit/query/react";

// const baseQuery = fetchBaseQuery({ baseUrl: '' });

export const apiSlice = createApi({
  reducerPath: "api",
  baseQuery: fetchBaseQuery({
    baseUrl: "http://backend:80",
    credentials: "include",
  }),
  tagTypes: ["User"],
  endpoints: (builder) => ({}),
});
